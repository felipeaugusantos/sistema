unit untCadBziColorantes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls, Mask,
  DBCtrls, DBEditFocus, EditFocus, DB, AppEvnts, Uni, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade;

type
  TfrmCadBziColorantes = class(TfrmPaiCad)
    pnlCentral: TPanel;
    Label1: TLabel;
    dbeCodCol: TDBEditFocus;
    Label2: TLabel;
    dbePreCus: TDBEditFocus;
    Label3: TLabel;
    dbeMargem: TDBEditFocus;
    Label4: TLabel;
    dbePreVen: TDBEditFocus;
    Label8: TLabel;
    edtDesIte: TEditFocus;
    dbeCodIte: TDBEditFocus;
    pnlCabecalho: TPanel;
    btnRestPreco: TSpeedButton;
    dtsBziCadCol: TDataSource;
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbeCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnRestPrecoClick(Sender: TObject);
    procedure dbeCodIteExit(Sender: TObject);
  private
    { Private declarations }

    qryCadIte: TUniQuery;
    strCodIteAnt : String;

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
  frmCadBziColorantes: TfrmCadBziColorantes;

implementation

uses untPai, untModuloTinta,
     untPesqAux, untFuncTinta, untFuncoesSimples,
     untTypesSistema, untConsultas;

{$R *.dfm}

{ TfrmCadBzaColorantes }

function TfrmCadBziColorantes.fRetPrecoVenda(intOpcao: Integer): Double;
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

function TfrmCadBziColorantes.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    fltPrecus: Double;
    fltMargem: Double;
    fltPreVen: Double;
begin
  Result := True;

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

  {*****************************************}
  {* VALIDA O ITEM COLORANTE               *}
  {**************************************MV*}
  Else If (Sender = dbeCodIte) Then
  Begin

//    If (fEmptyStr(dbeCodIte.Text)) Then
//    Begin
//      fMensagem('ATENÇÃO!', 'O Item Colorante deve ser preenchido!', ['&O k']);
//      Result := False;
//    End
//    Else
    If Not fEmptyStr(dbeCodIte.Text) Then
    Begin
      pCarregaItem;
      If fExisteValorNoCampo(dbeCodIte.Text, 'COL_CODITE', 'BZI_CADCOL', 'AUTOINCREM <> ' + QuotedStr(qryTabela.FieldByName('AUTOINCREM').AsString)) Then
      Begin
        Result := fMensagem('ATENÇÃO', 'Esse item já está relacionado a outro colorante!'#10#13'Deseja continuar ?', ['Sim', 'Não'], 2) = 1;
      End
      Else If (Not fItemAtivo(dbeCodIte.Text)) Then
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

  End

  Else If Not fEmptyStr(dbeCodIte.Text) Then
  Begin
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
  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCadBziColorantes.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  strCodIteAnt := '';
  
  edtDesIte.Clear;
  qryTabela.FieldByName('COL_CODEMP').AsString := VS_strCodEmp;
  pSetFocus(dbeCodCol);

  pHabilitaBtn;
end;

procedure TfrmCadBziColorantes.btnAlterarClick(Sender: TObject);
begin
  strCodIteAnt := dbeCodIte.Text;
  inherited;
  dbeCodCol.Enabled := False;
  pSetFocus(dbeCodIte);

  pHabilitaBtn;
end;

procedure TfrmCadBziColorantes.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('COL_CODCOL');
  stlCampos.Add('COL_PRECUS');
  stlCampos.Add('COL_MARGEM');
  stlCampos.Add('COL_PREVEN');
  stlCampos.Add('COL_PESESP');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('COL_CODCOL');
  stlCamInd.Add('ITE_CODITE');
  stlCamInd.Add('ITE_DESITE+ITE_REFERE');

  stlDesInd.Add('Código do Colorante');
  stlDesInd.Add('Código do Item');
  stlDesInd.Add('Descrição do Item/Referência do Item');

end;

procedure TfrmCadBziColorantes.FormCreate(Sender: TObject);
begin
  inherited;
  qryTabela     := frmModuloTinta.qryBzi_CadCol;
  strNomeTabela := 'BZI_CADCOL';
  strNomeCampo  := 'COL_CODCOL';

  dtsBziCadCol.DataSet := frmModuloTinta.qryBzi_CadCol;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodCol;

  qryCadIte := fCriarQuery('SELECT * FROM CADITE WHERE FALSE', Self);
  pSetaQueryCadIte(qryCadIte);
end;

procedure TfrmCadBziColorantes.dbeCodIteKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmCadBziColorantes.pCarregaItem;
begin
  pPesquisaCadIte(qryCadIte, qryCadIte, dbeCodIte.Text);
  With qryCadIte Do
  Begin
    edtDesIte.Text := FieldByName('ITE_DESITE').AsString;
  End;

  pHabilitaBtn;
end;

procedure TfrmCadBziColorantes.btnPesquisaClick(Sender: TObject);
  var
    arrSel: TConsultasArray;
    chrKey: char;
begin
  chrKey := '/';
  If fPesqColorantes(Self,
                     conBzi,
                     dbeCodCol,
                     dbeCodIte,
                     qryTabela,
                     chrKey,
                     arrSel,
                     True,
                     '',
                     '',
                     False) then
  Begin
    dbePreCus.Text := qryTabela.FieldByName('COL_PRECUS').AsString;
    dbeMargem.Text := qryTabela.FieldByName('COL_MARGEM').AsString;
    dbePreVen.Text := qryTabela.FieldByName('COL_PREVEN').AsString;

    pCarregaItem;
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadBziColorantes.btnExcluirClick(Sender: TObject);
begin
  strCodIteAnt := dbeCodIte.Text;
  inherited;

  if fEmptyStr(dbeCodIte.Text) Then
    pEnviarLogRep(strCodIteAnt, 'BZI');

  pCarregaItem;

end;

procedure TfrmCadBziColorantes.pHabilitaBtn;
begin
  If (qryTabela.State <> dsEdit) Then
    btnRestPreco.Visible := False
  Else
    btnRestPreco.Visible := True;
end;

procedure TfrmCadBziColorantes.btnGravarClick(Sender: TObject);
begin
  qryTabela.FieldByName('COL_PESESP').AsFloat := 1;
  inherited;

  If Not fEmptyStr(strCodIteAnt) Then
  Begin
    if (strCodIteAnt <> dbeCodIte.Text) Then
    begin
      pEnviarLogRep(strCodIteAnt, 'BZI');
    End;
  End;

  pHabilitaBtn;
  pAtualizarFatorTintometrico;
end;

procedure TfrmCadBziColorantes.btnRestPrecoClick(Sender: TObject);
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

procedure TfrmCadBziColorantes.dbeCodIteExit(Sender: TObject);
begin
  inherited;
  pCarregaItem;
end;

procedure TfrmCadBziColorantes.pAtualizarFatorTintometrico;
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'UPDATE CADITE INNER JOIN BZI_CADCOL ON COL_CODITE = ITE_CODITE SET ITE_CNV_ML = 1000';
  qryGen.ExecSQL;
  FreeAndNil(qryGen);
end;

end.


