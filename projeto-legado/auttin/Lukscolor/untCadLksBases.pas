unit untCadLksBases;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls, Mask,
  DBCtrls, DBEditFocus, EditFocus, StrUtils, DB, AppEvnts, Uni,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadLksBases = class(TfrmPaiCad)
    pnlCentral: TPanel;
    pnlCabecalho: TPanel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label16: TLabel;
    edtDesIte: TEditFocus;
    dbeBase: TDBEditFocus;
    dbeUnidad: TDBEditFocus;
    dbeDescri: TDBEditFocus;
    dbeCodIte: TDBEditFocus;
    edtDesUni: TEditFocus;
    Label1: TLabel;
    dbeCodPro: TDBEditFocus;
    btnRestPreco: TSpeedButton;
    edtSigUni: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure dbeUnidadKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnRestPrecoClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
    dbeCodEmp: TDBEdit;
    qryCon002: TUniQuery;

    procedure pCarregaUnidade;
    procedure pCarregaItem;
    procedure pHabilitaBtn;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCadLksBases: TfrmCadLksBases;

implementation

uses
  untConstantes, untPesqAux, untModuloTinta,
  untFuncTinta, untFuncoesSimples,
  untFuncoesConsulta, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmCadLksBases }

function TfrmCadLksBases.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strDesUni: String;
    strSigUni: String;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA A BASE                         *}
    {**************************************MV*}
    If (Sender = dbeBase) Then
    Begin

      If (fEmptyStr(dbeBase.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A base deve ser preenchida!', ['&O k']);
        Result := False;
      End;

    End

    Else If (Sender = dbeCodPro) Then
    Begin

      If (fEmptyStr(dbeCodPro.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O produto deve ser preenchido!', ['&O k']);
        Result := False;
      End;

    End

    {*****************************************}
    {* VALIDA A UNIDADE                      *}
    {**************************************MV*}
    Else If (Sender = dbeUnidad) Then
    Begin

      If (fEmptyStr(dbeUnidad.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A unidade deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregaUnidade;
        If fEmptyStr(edtDesUni.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa unidade não está cadastrada!', ['&O k']);
          Result := False;
        End
        Else If (Pos(edtSigUni.Text, UNIDADES_BASE) <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa não é uma unidade válida (' + AnsiReplaceStr(UNIDADES_BASE, '_', ' ') + ')', ['&Ok']);
          Result := False;
        End
        Else If blnBuscaPorChave Then
        Begin
          If (Not fBuscaPorCamposChave) Then
          Begin
            strDesUni := edtDesUni.Text;
            strSigUni := edtSigUni.Text;
            pLimparCampos;
            edtDesUni.Text := strDesUni;
            edtSigUni.Text := strSigUni;
          End
          Else
          Begin
            pCarregaItem;
          End;
        End;
      End;

    End

    {*****************************************}
    {* VALIDA A DESCRIÇÃO                    *}
    {**************************************MV*}
    Else If (Sender = dbeDescri) Then
    Begin

      If (fEmptyStr(dbeDescri.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A descrição deve ser preenchida!', ['&O k']);
        Result := False;
      End;

    End

    {*****************************************}
    {* VALIDA O ITEM BASE                    *}
    {**************************************MV*}
    Else If (Sender = dbeCodIte) Then
    Begin

//      If (fEmptyStr(dbeCodIte.Text)) Then
//      Begin
//        fMensagem('ATENÇÃO!', 'O Item Base deve ser preenchido!', ['&O k']);
//        Result := False;
//      End
//      Else
      If Not fEmptyStr(dbeCodIte.Text) Then
      Begin
        pCarregaItem;
        If fExisteValorNoCampo(dbeCodIte.Text, 'BAS_CODITE', 'LKS_CADBAS', 'AUTOINCREM <> ' + QuotedStr(qryTabela.FieldByName('AUTOINCREM').AsString)) Then
        Begin
          Result := fMensagem('ATENÇÃO', 'Esse item já está relacionado a outra base!'#10#13'Deseja continuar ?', ['Sim', 'Não']) = 1;
        End
        Else If (Not fItemAtivo(dbeCodIte.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse item está inativo!', ['&O k']);
          Result := False;
        End
        Else If (qryCon002.FieldByName('ITE_CODITE').IsNull) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse item não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          If (qryTabela.State = dsInsert) And (blnBuscaPorChave) Then
          Begin
            dbeDescri.Field.AsString := qryCon002.FieldByName('ITE_DESITE').AsString;
          End;
        End;
      End;

    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadLksBases.pCarregaItem;
begin
  pPesquisaCadIte(qryCon002, qryCon002, dbeCodIte.Text);
  With qryCon002 Do
  Begin
    edtDesIte.Text := FieldByName('ITE_DESITE').AsString;
  End;

  pHabilitaBtn;
end;

procedure TfrmCadLksBases.pCarregaUnidade;
begin
  If Not fEmptyStr(dbeUnidad.Text) Then
  Begin
    edtDesUni.Text := fRetNomUnidade(dbeUnidad.Text);
    edtSigUni.Text := fRetSiglaUnidade(dbeUnidad.Text);
  End
  Else
  Begin
    edtDesUni.Clear;
    edtSigUni.Clear;
  End;
end;

procedure TfrmCadLksBases.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('BAS_CODBAS');
  stlCampos.Add('BAS_CODPRO');
  stlCampos.Add('BAS_UNIDAD');
  stlCampos.Add('BAS_CODEMP');
  stlCampos.Add('BAS_CODITE');
  stlCampos.Add('BAS_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('BAS_DESCRI+BAS_CODBAS+BAS_CODPRO');
  stlCamInd.Add('ITE_CODITE');
  stlCamInd.Add('ITE_DESITE+ITE_REFERE');

  stlDesInd.Add('Descrição/Base/Código do Produto');
  stlDesInd.Add('Código do Item');
  stlDesInd.Add('Descrição do Item/Referência do Item');
end;

procedure TfrmCadLksBases.FormCreate(Sender: TObject);
begin
  inherited;
  qryTabela     := frmModuloTinta.qryLks_CadBas;
  strNomeTabela := 'LKS_CADBAS';
  strNomeCampo  := 'BAS_CODBAS';

  {*****************************************}
  {* CRIA O CAMPO EMPRESA PARA SER USADO   *}
  {* NA FUNÇÃO DE BUSCA PARA ALTERAÇÃO     *}
  {**************************************MV*}
  dbeCodEmp            := TDBEdit.Create(Self);
  dbeCodEmp.DataField  := 'BAS_CODEMP';
  dbeCodEmp.DataSource := frmModuloTinta.dtsLks_CadBas;

  SetLength(arrCamposChave, 4);
  arrCamposChave[0] := dbeBase;
  arrCamposChave[1] := dbeCodPro;
  arrCamposChave[2] := dbeUnidad;
  arrCamposChave[3] := dbeCodEmp;

  qryCon002 := fCriarQuery('SELECT * FROM CADITE WHERE FALSE', Self);
end;

procedure TfrmCadLksBases.dbeUnidadKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel: TConsultasArray;
begin
  inherited;
  If fPesqUnidade(Self, dbeUnidad, edtDesUni, nil, nil, Key, arrSel) Then
    If fValidaCampos(dbeUnidad, True) Then
      SelectNext(ActiveControl, True, True);

end;

procedure TfrmCadLksBases.dbeCodIteKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  If fPesqItem(conIteSimples, Self, dbeCodIte, edtDesIte, nil, key, arrSel) Then
     SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadLksBases.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  
  qryTabela.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
  pSetFocus(dbeBase);

  edtDesUni.Clear;
  edtSigUni.Clear;
  edtDesIte.Clear;

  pHabilitaBtn;
end;

procedure TfrmCadLksBases.btnPesquisaClick(Sender: TObject);
  Var
    arrSel: TConsultasArray;
    Key: Char;
begin
  key := '/';
  If fPesqBaseTinta(Self, conCorInd, dbeBase, nil, qryTabela, key,  arrSel, True, '', '', False) Then
    pSetFocus(btnAlterar);
end;


procedure TfrmCadLksBases.btnExcluirClick(Sender: TObject);
begin
  inherited;
  pCarregaUnidade;
  pCarregaItem;
end;

procedure TfrmCadLksBases.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCarregaUnidade;
  pCarregaItem;
end;

procedure TfrmCadLksBases.btnAlterarClick(Sender: TObject);
begin
  inherited;
  dbeBase.Enabled   := False;
  dbeCodPro.Enabled := False;
  dbeUnidad.Enabled := False;

  If dbeCodIte.Enabled Then
    pSetFocus(dbeCodIte);

  pHabilitaBtn;
end;

procedure TfrmCadLksBases.btnRestPrecoClick(Sender: TObject);
begin
  inherited;
  dbeDescri.Field.AsString := qryCon002.FieldByName('ITE_DESITE').AsString;
end;

procedure TfrmCadLksBases.pHabilitaBtn;
begin
  If (qryTabela.State <> dsEdit) Then
    btnRestPreco.Visible := False
  Else
    btnRestPreco.Visible := True;
end;

procedure TfrmCadLksBases.btnGravarClick(Sender: TObject);
begin
  inherited;
  pHabilitaBtn;
end;

end.

