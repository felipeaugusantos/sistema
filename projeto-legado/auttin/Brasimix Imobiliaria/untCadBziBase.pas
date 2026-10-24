{*****************************************}
{* frmModuloCons.qryCon001 -> CADUNI     *}
{*               qryCon002 -> CADITE     *}
{**************************************MV*}

unit untCadBziBase;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiCad, Menus, ComCtrls, Buttons, ExtCtrls, DBCtrls,
  Mask, DBEditFocus, DB, EditFocus, StrUtils, Uni, AppEvnts,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadBziBases = class(TfrmPaiCad)
    Label1: TLabel;
    dbeLinha: TDBEditFocus;
    Label2: TLabel;
    dbeBase: TDBEditFocus;
    Label3: TLabel;
    dbeCodUni: TDBEditFocus;
    Label4: TLabel;
    dbeDescri: TDBEditFocus;
    Label5: TLabel;
    dbePreCus: TDBEditFocus;
    Label6: TLabel;
    dbeMargem: TDBEditFocus;
    Label7: TLabel;
    dbePreVen: TDBEditFocus;
    Label8: TLabel;
    dbeCodIte: TDBEditFocus;
    edtDesUni: TEditFocus;
    edtDesIte: TEditFocus;
    pnlFundo: TPanel;
    pnlCabecalho: TPanel;
    btnRestPreco: TSpeedButton;
    edtSigUni: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure dbeCodUniKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnRestPrecoClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure dbeCodIteExit(Sender: TObject);
  private
    { Private declarations }
    dbeCodEmp: TDBEdit;
    qryCon002: TUniQuery;

    procedure pCarregaUnidade;
    procedure pCarregaItem;

    function fRetPrecoVenda(intOpcao: Integer): Double;
    procedure pHabilitaBtn;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public

    { Public declarations }
  end;

var
  frmCadBziBases: TfrmCadBziBases;

implementation

uses untModuloTinta, untPesqAux,
      untConstantes, untPai,
      untFuncTinta, untFuncoesSimples,
      untFuncoesConsulta, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadBziBases.FormCreate(Sender: TObject);
  var
    intCont: Integer;
begin
  inherited;
  qryTabela     := frmModuloTinta.qryBzi_CadBas;
  strNomeTabela := 'BZI_CADBAS';
  strNomeCampo  := 'BAS_LINHA_';

  {*****************************************}
  {* CRIA O CAMPO EMPRESA PARA SER USADO   *}
  {* NA FUNÇÃO DE BUSCA PARA ALTERAÇÃO     *}
  {**************************************MV*}
  dbeCodEmp            := TDBEdit.Create(Self);
  dbeCodEmp.DataField  := 'BAS_CODEMP';
  dbeCodEmp.DataSource := frmModuloTinta.dtsBzi_CadBas;

  For intCont := 0 To ComponentCount - 1 Do
  Begin
    If (Components[intCont] is TDBEditFocus) Then
    Begin
      (Components[intCont] as TDBEditFocus).DataSource := frmModuloTinta.dtsBzi_CadBas;
    End;
  End;

  SetLength(arrCamposChave, 4);
  arrCamposChave[0] := dbeLinha;
  arrCamposChave[1] := dbeBase;
  arrCamposChave[2] := dbeCodUni;
  arrCamposChave[3] := dbeCodEmp;

  qryCon002 := fCriarQuery('SELECT * FROM CADITE WHERE FALSE', Self);
  pSetaQueryCadIte(qryCon002);

end;

{*****************************************}
{* CALCULA O PREÇO DE VENDA              *}
{**************************************MV*}
function TfrmCadBziBases.fRetPrecoVenda(intOpcao: Integer): Double;
begin

  If fEmptyStr(dbePreVen.Text) Then
    dbePreVen.Text := '0,00';

  If fEmptyStr(dbeMargem.Text) Then
    dbeMargem.Text := '0,00';

  Result := fCalculaPrecoVenda(intOpcao,
                               fStrToFloat(dbePreCus.Text),
                               fStrToFloat(dbePreVen.Text),
                               fStrToFloat(dbeMargem.Text),
                               0.0,
                               0.0,
                               0.0,
                               0.0);
end;

function TfrmCadBziBases.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strDesUni: String;
    strSigUni: String;
    fltPrecus: Double;
    fltMargem: Double;
    fltPreVen: Double;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA O CÓDIGO                       *}
    {**************************************MV*}
    If (Sender = dbeLinha) Then
    Begin

      If (fEmptyStr(dbeLinha.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A linha deve ser preenchida!', ['&O k']);
        Result := False;
      End;

    End

    {*****************************************}
    {* VALIDA A BASE                         *}
    {**************************************MV*}
    Else If (Sender = dbeBase) Then
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
    Else If (Sender = dbeCodUni) Then
    Begin

      If (fEmptyStr(dbeCodUni.Text)) Then
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

        Else If (Pos(dbeCodUni.Text, UNIDADES_BASE) <= 0) Then
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
        If fExisteValorNoCampo(dbeCodIte.Text, 'BAS_CODITE', 'BZI_CADBAS', 'AUTOINCREM <> ' + QuotedStr(qryTabela.FieldByName('AUTOINCREM').AsString)) Then
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
          pRetornaPrecos(dbeCodIte.Text, fltPrecus, fltMargem, fltPreVen);
          If (qryTabela.State = dsInsert) And (blnBuscaPorChave) Then
          Begin
            dbeDescri.Field.AsString := qryCon002.FieldByName('ITE_DESITE').AsString;
            dbePreCus.Field.AsFloat  := fltPrecus;
            dbeMargem.Field.AsFloat  := fltMargem;
            dbePreVen.Field.AsFloat  := fltPreVen;
          End;
        End;
      End;

    End

    Else If Not fEmptyStr(dbeCodIte.Text) Then
    Begin
      {*****************************************}
      {* VALIDA O PREÇO DE CUSTO               *}
      {**************************************MV*}
      If (Sender = dbePreCus) Then
      Begin

        If (fEmptyStr(dbePreCus.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O preço de custo deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else If (fStrToFloat(dbePreCus.Text) <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'O preço de custo deve maior que Zero!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          dbePreVen.Field.AsFloat := fRetPrecoVenda(1);
        End;

      End

      {*****************************************}
      {* VALIDA A MARGEM                       *}
      {**************************************MV*}
      Else If (Sender = dbeMargem) Then
      Begin

        If (fEmptyStr(dbeMargem.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A margem deve ser preenchida!', ['&O k']);
          Result := False;
        End
        Else If (fStrToFloat(dbeMargem.Text) < 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'A margem deve maior ou igual a Zero!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          dbePreVen.Field.AsFloat := fRetPrecoVenda(1);
        End;

      End

      {*****************************************}
      {* VALIDA O PREÇO DE VENDA               *}
      {**************************************MV*}
      Else If (Sender = dbePreVen) Then
      Begin

        If (fEmptyStr(dbePreVen.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O preço de venda deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else If (fStrToFloat(dbePreVen.Text) <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'O preço de venda que Zero!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          dbeMargem.Field.AsFloat := fRetPrecoVenda(2);
        End;

      End
    End

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCadBziBases.pCarregaItem;
begin
  pPesquisaCadIte(qryCon002, qryCon002, dbeCodIte.Text);
  With qryCon002 Do
  Begin
    edtDesIte.Text := FieldByName('ITE_DESITE').AsString;
  End;

  pHabilitaBtn;
end;

procedure TfrmCadBziBases.pCarregaUnidade;
begin
  if Not fEmptyStr(dbeCodUni.Text) then
  Begin
    edtDesUni.Text := fRetNomUnidade(dbeCodUni.Text);
    edtSigUni.Text := fRetSiglaUnidade(dbeCodUni.Text);
  End
  Else
  Begin
    edtDesUni.Clear;
    edtSigUni.Clear;
  End;

end;

procedure TfrmCadBziBases.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('BAS_LINHA_');
  stlCampos.Add('BAS_BASE__');
  stlCampos.Add('BAS_UNIDAD');
  stlCampos.Add('BAS_CODEMP');
  stlCampos.Add('BAS_CODITE');
  stlCampos.Add('BAS_DESCRI');
  stlCampos.Add('BAS_PRECUS');
  stlCampos.Add('BAS_MARGEM');
  stlCampos.Add('BAS_PREVEN');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('BAS_DESCRI+BAS_BASE__');
  stlCamInd.Add('BAS_LINHA_');
  stlCamInd.Add('ITE_CODITE');
  stlCamInd.Add('ITE_DESITE+ITE_REFERE');

  stlDesInd.Add('Descrição/Base');
  stlDesInd.Add('Linha');
  stlDesInd.Add('Código do Item');
  stlDesInd.Add('Descrição do Item/Referência do Item');

end;

procedure TfrmCadBziBases.dbeCodUniKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel: TConsultasArray;
    qryConsulta: TUniQuery;
begin
  inherited;
  qryConsulta := fCriaQuery;
  Try
    if fPesqUnidade(Self, dbeCodUni, edtDesUni, Nil, qryConsulta, Key, arrSel) then
      if fValidaCampos(dbeCodUni, True) then
      Begin
        edtSigUni.Text := qryConsulta.FieldByName('UNI_SIGUNI').AsString;
        SelectNext(ActiveControl, True, True);
      End;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

procedure TfrmCadBziBases.dbeCodIteKeyPress(Sender: TObject; var Key: Char);
  Var
   arrSel: TConsultasArray;
begin
  If fPesqItem(conIteCompleta, Self, dbeCodIte, edtDesIte, nil, key, arrSel) Then
     SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadBziBases.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  
  qryTabela.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
  pSetFocus(dbeLinha);

  edtDesUni.Clear;
  edtDesIte.Clear;

  pHabilitaBtn;
end;

procedure TfrmCadBziBases.btnPesquisaClick(Sender: TObject);
  var
    arrSel: TConsultasArray;
    chr: Char;
begin
  chr := '/';
  If fPesqBaseTinta(Self, conBzi, dbeBase, nil, qryTabela, chr, arrSel, True, '', '', False) Then
  Begin
    pCarregaUnidade;
    pCarregaItem;
    pSetFocus(btnAlterar);
  End;

end;

procedure TfrmCadBziBases.btnExcluirClick(Sender: TObject);
begin
  inherited;
  pCarregaUnidade;
  pCarregaItem;
end;

procedure TfrmCadBziBases.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCarregaUnidade;
  pCarregaItem;
end;

procedure TfrmCadBziBases.btnAlterarClick(Sender: TObject);
begin
  inherited;
  dbeLinha.Enabled := False;
  dbeBase.Enabled := False;
  dbeCodUni.Enabled := False;

  If dbeCodIte.Enabled Then
    pSetFocus(dbeCodIte);

  pHabilitaBtn;
end;

procedure TfrmCadBziBases.btnRestPrecoClick(Sender: TObject);
  Var
    fltPrecus: Double;
    fltMargem: Double;
    fltPreVen: Double;
begin
  inherited;
  pRetornaPrecos(dbeCodIte.Text, fltPrecus, fltMargem, fltPreVen);
  dbeDescri.Field.AsString := qryCon002.FieldByName('ITE_DESITE').AsString;
  dbePreCus.Field.AsFloat  := fltPrecus;
  dbeMargem.Field.AsFloat  := fltMargem;
  dbePreVen.Field.AsFloat  := fltPreVen;
end;

procedure TfrmCadBziBases.pHabilitaBtn;
begin
  If (qryTabela.State <> dsEdit) Then
    btnRestPreco.Visible := False
  Else
    btnRestPreco.Visible := True;
end;

procedure TfrmCadBziBases.btnGravarClick(Sender: TObject);
begin
  inherited;
  pHabilitaBtn;

end;

procedure TfrmCadBziBases.dbeCodIteExit(Sender: TObject);
begin
  inherited;
  pCarregaItem;
end;

end.



