{*****************************************}
{*               qryCon002 -> CADITE     *}
{**************************************MV*}

unit untCadBzaBase;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiCad, Menus, ComCtrls, Buttons, ExtCtrls, DBCtrls,
  Mask, DBEditFocus, DB, EditFocus, StrUtils, AppEvnts, Uni,
  BitBtnLockedIncrem;

type
  TfrmCadBzaBases = class(TfrmPaiCad)
    Label1: TLabel;
    dbeCodBas: TDBEditFocus;
    Label4: TLabel;
    dbeDescri: TDBEditFocus;
    Label8: TLabel;
    dbeCodIte: TDBEditFocus;
    edtDesIte: TEditFocus;
    pnlFundo: TPanel;
    pnlCabecalho: TPanel;
    dtsBzaCadBas: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure dbeCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
    dbeCodEmp: TDBEdit;
    qryCon002: TUniQuery;
    procedure pCarregaItem;

  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    procedure pAtualizarFatorTintometrico();
    { Public declarations }
  end;

var
  frmCadBzaBases: TfrmCadBzaBases;

implementation

uses untModuloTinta, untPesqAux,
     untConsultaFatItem, untPai,
     untFuncoesSimples, untFuncTinta;

{$R *.dfm}

procedure TfrmCadBzaBases.FormCreate(Sender: TObject);
begin
  inherited;
  qryTabela     := frmModuloTinta.qryBza_CadBas;
  strNomeTabela := 'BZA_CADBAS';
  strNomeCampo  := 'BAS_CODBAS';

  dtsBzaCadBas.DataSet := frmModuloTinta.qryBza_CadBas;

  {*****************************************}
  {* CRIA O CAMPO EMPRESA PARA SER USADO   *}
  {* NA FUNÇÃO DE BUSCA PARA ALTERAÇÃO     *}
  {**************************************MV*}
  dbeCodEmp            := TDBEdit.Create(Self);
  dbeCodEmp.DataField  := 'BAS_CODEMP';
  dbeCodEmp.DataSource := frmModuloTinta.dtsBza_CadBas;

  SetLength(arrCamposChave, 2);
  arrCamposChave[0] := dbeCodBas;
  arrCamposChave[1] := dbeCodEmp;

  qryCon002 := fCriarQuery('SELECT * FROM CADITE WHERE FALSE', Self);
end;

function TfrmCadBzaBases.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA O CÓDIGO                       *}
    {**************************************MV*}
    If (Sender = dbeCodBas) Then
    Begin

      If (fEmptyStr(dbeCodBas.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código da base deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        fBuscaPorCamposChave;
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

      If Not fEmptyStr(dbeCodIte.Text) Then
      Begin
        If fExisteValorNoCampo(dbeCodIte.Text, 'BAS_CODITE', 'BZA_CADBAS', 'AUTOINCREM <> ' + QuotedStr(qryTabela.FieldByName('AUTOINCREM').AsString)) Then
        Begin
          Result := fMensagem('ATENÇÃO', 'Esse item já está relacionado a outra base!'#10#13'Deseja continuar ?', ['Sim', 'Não']) = 1;
        End
        Else
        Begin
          pCarregaItem;
          If (qryCon002.FieldByName('ITE_CODITE').IsNull) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse item não está cadastrado!', ['&Ok']);
            Result := False;
          End;
        End;
      End;



    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCadBzaBases.pCarregaItem;
begin
  pPesquisaCadIte(qryCon002, qryCon002, dbeCodIte.Text);
  With qryCon002 Do
  Begin
    edtDesIte.Text := FieldByName('ITE_DESITE').AsString;
  End;
end;

procedure TfrmCadBzaBases.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('BAS_CODBAS');
  stlCampos.Add('BAS_CODEMP');
  stlCampos.Add('BAS_CODITE');
  stlCampos.Add('BAS_DESBAS');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('BAS_DESBAS');
  stlCamInd.Add('BAS_CODBAS');
  stlCamInd.Add('BAS_CODITE');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Base');
  stlDesInd.Add('Item Base');

end;

procedure TfrmCadBzaBases.dbeCodIteKeyPress(Sender: TObject; var Key: Char);
  Var
    stlCamIndIte: TStringList;
    stlDesIndIte: TStringList;
    strSQL: String;
begin

  If (fEntraCons(Key)) Then
  Begin

    stlCamIndIte := TStringList.Create;
    stlDesIndIte := TStringList.Create;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  I.ITE_CODITE AS "Codigo", ';
    strSQL := strSQL + '  I.ITE_DESITE AS "Descrição", ';
    strSQL := strSQL + '  I.ITE_REFERE AS "Referência", ';
    strSQL := strSQL + '  I.ITE_CODUNI AS "Unidade", ';
    strSQL := strSQL + '  G.ITE_PREVE1 AS "Preço de Venda", ';
    strSQL := strSQL + '  I.ITE_CODMAR As "Cód. Marca", ';
    strSQL := strSQL + '  M.MAR_DESMAR As "Marca", ';
    strSQL := strSQL + '  I.AUTOINCREM AS "AUTOINCREM", ';
    strSQL := strSQL + '  IF(I.ITE_ITEATI = "S", "ATIVO", "INATIVO") AS ITE_ITEATI, ';
    strSQL := strSQL + '  I.ITE_CODSIM, ';
    strSQL := strSQL + '  G.ITE_SALDOS, ';
    strSQL := strSQL + '  ITE_PRECUS, ';
    strSQL := strSQL + '  DATEDIFF(CURRENT_DATE, ITE_DTAUVE) ULTVEN ';
//    strSQL := strSQL + '  G.ITE_SALRES ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADITE I, ';
    strSQL := strSQL + '  ITEGER G, ';
    strSQL := strSQL + '  CADMAR M ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  I.ITE_CODMAR = M.MAR_CODMAR AND ';
    strSQL := strSQL + '  I.ITE_CODITE = G.ITE_CODITE AND ';
    strSQL := strSQL + '  G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';

    stlCamIndIte.Add('I.ITE_CODITE');
    stlCamIndIte.Add('I.ITE_DESITE');
    stlCamIndIte.Add('I.ITE_REFERE');
    stlCamIndIte.Add('I.ITE_CODBAR');

    stlDesIndIte.Add('Codigo');
    stlDesIndIte.Add('Descrição');
    stlDesIndIte.Add('Referência');

    Application.CreateForm(TfrmConsultaFatItem, frmConsultaFatItem);

    If pConsultaEspecifica(Self, frmConsultaFatItem, qryCon002, 'CADITE',
        strSQL, stlCamIndIte, stlDesIndIte) Then
    Begin

      dbeCodIte.Text := qryCon002.FieldByName('ITE_CODITE').AsString;
      pCarregaItem;
      SelectNext(ActiveControl, True, True);

    End;

    FreeAndNil(frmConsultaFatItem);

    FreeAndNil(stlCamIndIte);
    FreeAndNil(stlDesIndIte);

  End;

end;

procedure TfrmCadBzaBases.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  
  qryTabela.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
  pSetFocus(dbeCodBas);
  edtDesIte.Clear;
end;

procedure TfrmCadBzaBases.btnPesquisaClick(Sender: TObject);
begin
  inherited;
  pCarregaItem;
end;

procedure TfrmCadBzaBases.btnExcluirClick(Sender: TObject);
begin
  inherited;
  pCarregaItem;
end;

procedure TfrmCadBzaBases.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCarregaItem;
end;

procedure TfrmCadBzaBases.btnAlterarClick(Sender: TObject);
begin
  inherited;
  dbeCodBas.Enabled := False;

  If dbeDescri.Enabled Then
    pSetFocus(dbeDescri);
end;


procedure TfrmCadBzaBases.pAtualizarFatorTintometrico;
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'UPDATE CADITE INNER JOIN BZA_CADBAS ON BAS_CODITE = ITE_CODITE SET ITE_CNV_ML = (BAS_EMBALA * BAS_PESPEC)';
  qryGen.ExecSQL;
  FreeAndNil(qryGen);
end;

procedure TfrmCadBzaBases.btnGravarClick(Sender: TObject);
begin
  inherited;
  pAtualizarFatorTintometrico;
end;

end.

