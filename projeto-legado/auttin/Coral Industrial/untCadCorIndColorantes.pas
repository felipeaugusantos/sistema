unit untCadCorIndColorantes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls, Mask,
  DBCtrls, DBEditFocus, EditFocus, DB, AppEvnts, Uni, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade;

type
  TfrmCadCorIndColorantes = class(TfrmPaiCad)
    pnlCentral: TPanel;
    pnlCabecalho: TPanel;
    Label1: TLabel;
    dbeCodCol: TDBEditFocus;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label8: TLabel;
    dbePreCus: TDBEditFocus;
    dbeMargem: TDBEditFocus;
    dbePreVen: TDBEditFocus;
    edtDesIte: TEditFocus;
    dbeCodIte: TDBEditFocus;
    btnRestPreco: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure dbeCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnRestPrecoClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure dbeCodIteExit(Sender: TObject);
  private
    { Private declarations }
    dbeCodEmp: TDBEdit;
    qryCadIte: TUniQuery;
    function fRetPrecoVenda(intOpcao: Integer): Double;
    procedure pCarregaItem;
    procedure pHabilitaBtn;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    procedure pAtualizarFatorTintometrico;
  end;

var
  frmCadCorIndColorantes: TfrmCadCorIndColorantes;

implementation

uses untModuloTinta, untPesqAux,
     untFuncTinta, untFuncoesSimples,
     untTypesSistema, untConsultas;

{$R *.dfm}

{ TfrmCadCorIndColorantes }

function TfrmCadCorIndColorantes.fRetPrecoVenda(intOpcao: Integer): Double;
begin
  If fEmptyStr(dbePreVen.Text) Then
    dbePreVen.Text := '0,000';

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

function TfrmCadCorIndColorantes.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    fltPrecus: Double;
    fltMargem: Double;
    fltPreVen: Double;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = dbeCodCol) Then
    Begin

      If (fEmptyStr(dbeCodCol.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        If (Not fBuscaPorCamposChave) Then
        Begin
          pLimparCampos;
        End;
      End;

    End

    Else If (Sender = dbePreCus) And (dbePreCus.Enabled) Then
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

    Else If (Sender = dbeMargem) And (dbePreCus.Enabled) Then
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

    Else If (Sender = dbePreVen) And (dbePreCus.Enabled) Then
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

    {*****************************************}
    {* VALIDA O ITEM COLORANTE               *}
    {**************************************MV*}
    Else If (Sender = dbeCodIte) Then
    Begin

//      If (fEmptyStr(dbeCodIte.Text)) Then
//      Begin
//        fMensagem('ATENÇÃO!', 'O Item Colorante deve ser preenchido!', ['&O k']);
//        Result := False;
//      End
      If Not fEmptyStr(dbeCodIte.Text) Then
      Begin
        If fExisteValorNoCampo(dbeCodIte.Text, 'COL_CODITE', 'CORIND_CADCOL', 'AUTOINCREM <> ' + QuotedStr(qryTabela.FieldByName('AUTOINCREM').AsString)) Then
        Begin
          Result := fMensagem('ATENÇÃO', 'Esse item já está relacionado a outro colorante!'#10#13'Deseja continuar ?', ['Sim', 'Não'], 2) = 1;
        End
        Else
        Begin
          pCarregaItem;
          If (Not fItemAtivo(dbeCodIte.Text)) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse item está inativo!', ['&O k']);
            Result := False;
          End
          Else If (qryCadIte.FieldByName('ITE_CODITE').IsNull) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse item não está cadastrado!', ['&O k']);
            Result := False;
          End
          Else
          Begin
            pRetornaPrecos(dbeCodIte.Text, fltPrecus, fltMargem, fltPreVen);
            If (qryTabela.State = dsInsert) And (blnBuscaPorChave) Then
            Begin
              dbePreCus.Field.AsFloat  := fltPrecus;
              dbeMargem.Field.AsFloat  := fltMargem;
              dbePreVen.Field.AsFloat  := fltPreVen;
            End;
          End;
        End;
      End;


    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCadCorIndColorantes.pCarregaItem;
begin
  pPesquisaCadIte(qryCadIte, qryCadIte, dbeCodIte.Text);
  With qryCadIte Do
  Begin
    edtDesIte.Text := FieldByName('ITE_DESITE').AsString;
  End;
end;

procedure TfrmCadCorIndColorantes.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('COL_CODCOL');
  stlCampos.Add('COL_PRECUS');
  stlCampos.Add('COL_MARGEM');
  stlCampos.Add('COL_PREVEN');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('COL_CODCOL');
  stlCamInd.Add('ITE_CODITE');
  stlCamInd.Add('ITE_DESITE+ITE_REFERE');

  stlDesInd.Add('Código do Colorante');
  stlDesInd.Add('Código do Item');
  stlDesInd.Add('Descrição do Item/Referência do Item');


end;

procedure TfrmCadCorIndColorantes.FormCreate(Sender: TObject);
begin
  inherited;
  qryTabela     := frmModuloTinta.qryCorInd_CadCol;
  strNomeTabela := 'CORIND_CADCOL';
  strNomeCampo  := 'COL_CODCOL';

  {*****************************************}
  {* CRIA O CAMPO EMPRESA PARA SER USADO   *}
  {* NA FUNÇÃO DE BUSCA PARA ALTERAÇÃO     *}
  {**************************************MV*}
  dbeCodEmp            := TDBEdit.Create(Self);
  dbeCodEmp.DataField  := 'COL_CODEMP';
  dbeCodEmp.DataSource := frmModuloTinta.dtsCorInd_CadCol;

  SetLength(arrCamposChave, 2);
  arrCamposChave[0] := dbeCodCol;
  arrCamposChave[1] := dbeCodEmp;

  qryCadIte := fCriarQuery('SELECT * FROM CADITE WHERE FALSE', Self);
end;

procedure TfrmCadCorIndColorantes.btnIncluirClick(Sender: TObject);
begin
  inherited;
  qryTabela.FieldByName('COL_CODEMP').AsString := VS_strCodEmp;
  qryTabela.FieldByName('COL_PRECUS').AsFloat  := 0.0;
  qryTabela.FieldByName('COL_MARGEM').AsFloat  := 0.0;
  qryTabela.FieldByName('COL_PREVEN').AsFloat  := 0.0;
  pSetFocus(dbeCodCol);
  edtDesIte.Clear;

  pHabilitaBtn;
end;

procedure TfrmCadCorIndColorantes.btnAlterarClick(Sender: TObject);
begin
  inherited;
  dbeCodCol.Enabled := False;
  If (dbeCodIte.Enabled) Then
    pSetFocus(dbeCodIte);

  pHabilitaBtn;
end;

procedure TfrmCadCorIndColorantes.dbeCodIteKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  If fPesqItem(conIteSimples,
               Self,
               dbeCodIte,
               edtDesIte,
               nil,
               key,
               arrSel) then
  Begin
    if fValidaCampos(dbeCodIte) then
      SelectNext(ActiveControl, True, True);
  End;
end;


procedure TfrmCadCorIndColorantes.btnPesquisaClick(Sender: TObject);
  var
    arrSel: TConsultasArray;
    chrKey: char;
begin
  chrKey := '/';
  If fPesqColorantes(Self,
                     conCorInd,
                     dbeCodCol,
                     dbeCodIte,
                     qryTabela,
                     chrKey,
                     arrSel, True, '', '', False) then
  Begin
    dbePreCus.Text := qryTabela.FieldByName('COL_PRECUS').AsString;
    dbeMargem.Text := qryTabela.FieldByName('COL_MARGEM').AsString;
    dbePreVen.Text := qryTabela.FieldByName('COL_PREVEN').AsString;

    pCarregaItem;
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadCorIndColorantes.btnExcluirClick(Sender: TObject);
begin
  inherited;
  pCarregaItem;
end;

procedure TfrmCadCorIndColorantes.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCarregaItem;
end;

procedure TfrmCadCorIndColorantes.btnRestPrecoClick(Sender: TObject);
  Var
    fltPrecus: Double;
    fltMargem: Double;
    fltPreVen: Double;
begin
  inherited;
  pRetornaPrecos(dbeCodIte.Text, fltPrecus, fltMargem, fltPreVen);
  dbePreCus.Field.AsFloat  := fltPrecus;
  dbeMargem.Field.AsFloat  := fltMargem;
  dbePreVen.Field.AsFloat  := fltPreVen;
end;

procedure TfrmCadCorIndColorantes.pHabilitaBtn;
begin
  If (qryTabela.State <> dsEdit) Then
    btnRestPreco.Visible := False
  Else
    btnRestPreco.Visible := True;
end;

procedure TfrmCadCorIndColorantes.btnGravarClick(Sender: TObject);
begin
  inherited;
  pHabilitaBtn;
  pAtualizarFatorTintometrico;
end;

procedure TfrmCadCorIndColorantes.dbeCodIteExit(Sender: TObject);
begin
  inherited;
  pCarregaItem;
end;

procedure TfrmCadCorIndColorantes.pAtualizarFatorTintometrico;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'UPDATE CADITE INNER JOIN CORIND_CADCOL ON ITE_CODITE = COL_CODITE SET ITE_CNV_ML = 1000';
  qryGen.ExecSQL;
  FreeAndNil(qryGen);
end;

end.

