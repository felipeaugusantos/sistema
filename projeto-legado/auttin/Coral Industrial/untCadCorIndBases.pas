unit untCadCorIndBases;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls, Mask,
  DBCtrls, DBEditFocus, EditFocus, StrUtils, DB, Uni, AppEvnts,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadCorIndBases = class(TfrmPaiCad)
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
    procedure FormCreate(Sender: TObject);
    procedure dbeUnidadKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure dbeCodIteExit(Sender: TObject);
  private
    { Private declarations }
    dbeCodEmp: TDBEdit;
    qryCon002: TUniQuery;

    procedure pCarregaCadUni;
    procedure pCarregaItem;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCadCorIndBases: TfrmCadCorIndBases;

implementation

uses untConstantes, untPesqAux, untModuloTinta,
     untFuncTinta, untFuncoesSimples,
     untFuncoesConsulta, untTypesSistema, untConsultas;

{$R *.dfm}

{ TfrmCadCorIndBases }

function TfrmCadCorIndBases.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strDesUni: String;
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

        pCarregaCadUni;
        If fEmptyStr(edtDesUni.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa unidade não está cadastrada!', ['&O k']);
          Result := False;
        End

        Else If (Pos(dbeUnidad.Text, UNIDADES_BASE) <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa não é uma unidade válida (' + AnsiReplaceStr(UNIDADES_BASE, '_', ' ') + ')', ['&Ok']);
          Result := False;
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
      End
      Else If blnBuscaPorChave Then
      Begin
        If (Not fBuscaPorCamposChave) Then
        Begin
          strDesUni := edtDesUni.Text;
          pLimparCampos;
          edtDesUni.Text := strDesUni;
        End
        Else
        Begin
          pCarregaItem;
        End;
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
      If (Not fEmptyStr(dbeCodIte.Text)) Then
      Begin
        pCarregaItem;
        If fExisteValorNoCampo(dbeCodIte.Text, 'BAS_CODITE', 'CORIND_CADBAS', 'AUTOINCREM <> ' + QuotedStr(qryTabela.FieldByName('AUTOINCREM').AsString)) Then
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
        End;
      End;

    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadCorIndBases.pCarregaCadUni;
begin
  edtDesUni.Text := fRetNomUnidade(dbeUnidad.Text);
end;

procedure TfrmCadCorIndBases.pCarregaItem;
begin
  pPesquisaCadIte(qryCon002, qryCon002, dbeCodIte.Text);
  With qryCon002 Do
  Begin
    edtDesIte.Text := FieldByName('ITE_DESITE').AsString;
  End;
end;

procedure TfrmCadCorIndBases.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('BAS_BASE__');
  stlCampos.Add('BAS_UNIDAD');
  stlCampos.Add('BAS_CODEMP');
  stlCampos.Add('BAS_CODITE');
  stlCampos.Add('BAS_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('BAS_DESCRI+BAS_BASE__');
  stlCamInd.Add('ITE_CODITE');
  stlCamInd.Add('ITE_DESITE+ITE_REFERE');

  stlDesInd.Add('Descrição/Base');
  stlDesInd.Add('Código do Item');
  stlDesInd.Add('Descrição do Item/Referência do Item');
end;

procedure TfrmCadCorIndBases.FormCreate(Sender: TObject);
begin
  inherited;
  qryTabela     := frmModuloTinta.qryCorInd_CadBas;
  strNomeTabela := 'CORIND_CADBAS';
  strNomeCampo  := 'BAS_BASE__';

  {*****************************************}
  {* CRIA O CAMPO EMPRESA PARA SER USADO   *}
  {* NA FUNÇÃO DE BUSCA PARA ALTERAÇÃO     *}
  {**************************************MV*}
  dbeCodEmp            := TDBEdit.Create(Self);
  dbeCodEmp.DataField  := 'BAS_CODEMP';
  dbeCodEmp.DataSource := frmModuloTinta.dtsCorInd_CadBas;

  SetLength(arrCamposChave, 4);
  arrCamposChave[0] := dbeBase;
  arrCamposChave[1] := dbeUnidad;
  arrCamposChave[2] := dbeCodEmp;
  arrCamposChave[3] := dbeDescri;

  qryCon002 := fCriarQuery('SELECT * FROM CADITE WHERE FALSE', Self);
end;

procedure TfrmCadCorIndBases.dbeUnidadKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel: TConsultasArray;
begin
  inherited;
  If fPesqUnidade(Self, dbeUnidad, edtDesUni, nil, nil, Key, arrSel) Then
    If fValidaCampos(dbeUnidad, True) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadCorIndBases.dbeCodIteKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  If fPesqItem(conIteSimples, Self, dbeCodIte, edtDesIte, nil, key, arrSel) Then
     SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadCorIndBases.btnIncluirClick(Sender: TObject);
begin
  inherited;
  qryTabela.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
  pSetFocus(dbeBase);

  edtDesUni.Clear;
  edtDesIte.Clear;
end;

procedure TfrmCadCorIndBases.btnPesquisaClick(Sender: TObject);
  Var
    arrSel: TConsultasArray;
    Key: Char;
begin
  key := '/';

  If fPesqBaseTinta(Self, conCorInd, dbeBase, Nil, qryTabela, key,  arrSel, True, '', '', False) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadCorIndBases.btnExcluirClick(Sender: TObject);
begin
  inherited;
  pCarregaCadUni;
  pCarregaItem;
end;

procedure TfrmCadCorIndBases.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCarregaCadUni;
  pCarregaItem;
end;

procedure TfrmCadCorIndBases.btnAlterarClick(Sender: TObject);
begin
  inherited;
  dbeBase.Enabled := False;
  dbeUnidad.Enabled := False;

  If dbeDescri.Enabled Then
    pSetFocus(dbeDescri);
end;

procedure TfrmCadCorIndBases.dbeCodIteExit(Sender: TObject);
begin
  inherited;
  pCarregaItem;
end;

end.

