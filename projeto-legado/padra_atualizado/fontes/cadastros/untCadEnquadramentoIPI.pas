unit untCadEnquadramentoIPI;

interface

uses
  Windows, Controls, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons, Classes,
  ExtCtrls, Mask, DBCtrls, DBEditFocus, Uni, DB, EditFocus, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade, DBComboBoxFocus, DBMemoFocus, SysUtils;

type
  TfrmCadEnquadramentoIPI = class(TfrmPaiCad)
    pnlFundo: TPanel;
    Label1: TLabel;
    dbeCodigo: TDBEditFocus;
    dbeDescri: TDBmEMOFocus;
    Label2: TLabel;
    dbcGruCst: TDBComboBoxFocus;
    Label156: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbeDescriEnter(Sender: TObject);
    procedure dbeDescriKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    qryEnqIpi: TUniQuery;
    dtsEnqIpi: TDataSource;
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

{ TfrmCadEnquadramentoIPI }

procedure TfrmCadEnquadramentoIPI.pCriaDataSets;
begin
  {**********************************}
  {* CRIA OS DATASETS DINAMICAMENTE *}
  {*******************************PH*}
  qryEnqIpi := fCriarQuery('SELECT * FROM ENQIPI', Self);

  qryEnqIpi.FieldByName('EQI_CODIGO').DisplayLabel := 'Código';
  qryEnqIpi.FieldbyName('EQI_DESCRI').DisplayLabel := 'Descrição';
  qryEnqIpi.FieldByName('AUTOINCREM').Visible := False;

  dtsEnqIpi := fCriaDataSource(qryEnqIpi);

  qryEnqIpi.AfterScroll := pAfterScrool;
end;

procedure TfrmCadEnquadramentoIPI.pLigaDataSets;
begin
  dbeCodigo.DataSource := dtsEnqIpi;
  dbeDescri.DataSource := dtsEnqIpi;
  dbcGruCst.DataSource := dtsEnqIpi;

  dbeCodigo.DataField := 'EQI_CODIGO';
  dbeDescri.DataField := 'EQI_DESCRI';
  dbcGruCst.DataField := 'EQI_GRUCST';

  qryTabela := qryEnqIpi;
  strNomeTabela := 'ENQIPI';
  strNomeCampo  := 'EQI_CODIGO';

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

procedure TfrmCadEnquadramentoIPI.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaDataSets;
  pLigaDataSets;
end;

procedure TfrmCadEnquadramentoIPI.FormShow(Sender: TObject);
begin
  inherited;
  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;
end;

function TfrmCadEnquadramentoIPI.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = dbeCodigo) Then
    Begin
      If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End;

    If Sender = dbeDescri Then
    Begin
      If fEmptyStr(dbeDescri.Text) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO', 'A descrição deve ser preenchida!', ['OK']);
      End;
    End;

    If Sender = dbcGruCst Then
    Begin
      If fEmptyStr(dbcGruCst.Text) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO', 'O grupo CST deve ser selecionado!', ['OK']);
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmCadEnquadramentoIPI.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('EQI_CODIGO');
  stlCampos.Add('EQI_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('EQI_DESCRI');
  stlCamInd.Add('EQI_CODIGO');
  stlCamInd.Add('AUTOINCREM');
  
  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

procedure TfrmCadEnquadramentoIPI.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadEnquadramentoIPI.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadEnquadramentoIPI.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[TfrmCadEnquadramentoIPI.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadEnquadramentoIPI.btnIncluirClick(Sender: TObject);
begin
  inherited;
  dbeCodigo.Enabled := Not blnUsaProCodigo;
  If blnUsaProCodigo Then
    pSetFocus(dbcGruCst)
  Else
    pSetFocus(dbeCodigo);
end;

procedure TfrmCadEnquadramentoIPI.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrSel: TConsultasArray;
begin
  chrKey := '/';
  If fPesqEnquadramentoIPI(Self, Nil, Nil, qryTabela, chrKey, arrSel) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadEnquadramentoIPI.dbeDescriEnter(Sender: TObject);
begin
  inherited;
  dbeDescri.SelectAll;
end;

procedure TfrmCadEnquadramentoIPI.dbeDescriKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (Key = #13) And (dbeDescri.SelText = dbeDescri.Text) Then
  Begin
    Key := #0;
    SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadEnquadramentoIPI.btnAlterarClick(Sender: TObject);
begin
  inherited;
  dbeCodigo.Enabled := False;
  pSetFocus(dbcGruCst);
end;

procedure TfrmCadEnquadramentoIPI.pAfterScrool(DataSet: TDataSet);
begin
//
end;

end.
