unit untCadAutBases;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, StdCtrls, Mask, DBCtrls, AppEvnts, Menus, ComCtrls,
  Buttons, ExtCtrls, EditFocus, DB, Uni, DBEditFocus, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade;

type
  TfrmCadAutBases = class(TfrmPaiCad)
    Panel1: TPanel;
    Label1: TLabel;
    pnlCabecalho: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    dbeDesIte: TEditFocus;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    dbeCodigo: TDBEditFocus;
    dbeDescricao: TDBEditFocus;
    dbeDensidade: TDBEditFocus;
    dbeEmbala: TDBEditFocus;
    dbeSistema: TDBEditFocus;
    dbeCodIte: TDBEditFocus;
    dbePreCus: TDBEditFocus;
    dbeMargem: TDBEditFocus;
    dbePreVen: TDBEditFocus;
    btnRestPreco: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure dbeCodIteExit(Sender: TObject);
    procedure dbeCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnRestPrecoClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
  private
    qryCadBas : TUniQuery;
    dtsCadBas : TDataSource;
    procedure pHabilitaBtn;
    { Private declarations }
  public
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
    function fCriarQuery(strTabela: String; AOwner: TComponent): TUniQuery;
    procedure pCriaDataSets;
    procedure pLigaDataSets;
    function fCarregaDesIte(strCodIte: String): String;
    function fRetPrecoVenda(intOpcao: Integer): Double;
    procedure pAtualizarFatorTintometrico();
    { Public declarations }
  end;

var
  frmCadAutBases: TfrmCadAutBases;

implementation

uses untPai, untFuncoesSimples, untFuncTinta,
  untConsultaCompRelacionamento;

{$R *.dfm}

{ TfrmCadAutBases }

function TfrmCadAutBases.fCriarQuery(strTabela: String;
  AOwner: TComponent): TUniQuery;
  Var
    intCont : Integer;
begin
  {******************************************************************}
  {* CRIA UMA TUniQuery E DEIXA OS CAMPOS FIXOS, ISSO EVITA QUE       *}
  {* QUANDO SE USA O METODO CLOSE, PERCA AS PROPRIEDADES DOS CAMPOS *}
  {***************************************************************PH*}

  Result := fCriaQuery(AOwner);
  Result.SQL.Text := 'SELECT * FROM ' + strTabela + ' WHERE FALSE;';
  Result.Open;
  Result.Close;

  For intCont := 0 To Result.FieldDefs.Count - 1 Do
  Begin
    Result.FieldDefs[intCont].CreateField(Result);
  End;
end;

procedure TfrmCadAutBases.pCriaDataSets;
begin
  qryCadBas := fCriarQuery('AUT_CADBAS', Self);

  qryCadBas.FieldByName('BAS_CODBAS').DisplayLabel := 'Base';
  qryCadBas.FieldByName('BAS_CODEMP').Visible := False;
  qryCadBas.FieldByName('BAS_CODITE').DisplayLabel := 'Código do Item';
  qryCadBas.FieldByName('BAS_DESBAS').DisplayLabel := 'Descrição';
  qryCadBas.FieldByName('AUTOINCREM').Visible := False;
  qryCadBas.FieldByName('BAS_PESPEC').DisplayLabel := 'Peso Específico';
  TFloatField(qryCadBas.FieldByName('BAS_PESPEC')).DisplayFormat := '0.000';
  qryCadBas.FieldByName('BAS_PRECUS').DisplayLabel := 'Preço Custo';
  qryCadBas.FieldByName('BAS_MARGEM').DisplayLabel := 'Margem';
  qryCadBas.FieldByName('BAS_PREVEN').DisplayLabel := 'Preco Venda';
  qryCadBas.FieldByName('BAS_EMBALA').DisplayLabel := 'Embalagem';
  TFloatField(qryCadBas.FieldByName('BAS_EMBALA')).DisplayFormat := '0.00';
  qryCadBas.FieldByName('BAS_MIXSCH').DisplayLabel := 'Sistema';

  dtsCadBas := fCriaDataSource(qryCadBas);
end;

procedure TfrmCadAutBases.pHabilitaBtn;
begin
  dbeDensidade.ReadOnly :=(qryTabela.State in [dsEdit]); 
end;

procedure TfrmCadAutBases.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('BAS_CODBAS');
  stlCampos.Add('BAS_DESBAS');
  stlCampos.Add('BAS_MIXSCH');
  stlCampos.Add('BAS_EMBALA');
  stlCampos.Add('BAS_PESPEC');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('BAS_DESBAS+BAS_CODBAS');
  stlCamInd.Add('BAS_MIXSCH');
  stlCamInd.Add('ITE_CODITE');
  stlCamInd.Add('ITE_DESITE+ITE_REFERE');

  stlDesInd.Add('Descrição/Base');
  stlDesInd.Add('Sistema');
  stlDesInd.Add('Código do Item');
  stlDesInd.Add('Descrição do Item/Referência do Item');


end;

procedure TfrmCadAutBases.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaDataSets;
  pLigaDataSets;

  strNomeTabela := 'AUT_CADBAS';
  strNomeCampo  := 'BAS_CODBAS';
  qryTabela     := qryCadBas;
end;

procedure TfrmCadAutBases.pLigaDataSets;
  Var
    intCont : Integer;
begin
  For intCont := 0 To Self.ComponentCount - 1 Do
  Begin
    If Components[intCont] is TDBEdit Then
      TDBEdit(Components[intCont]).DataSource := dtsCadBas;
  End;

  dbeCodigo.DataField     := 'BAS_CODBAS';
  dbeCodIte.DataField     := 'BAS_CODITE';
  dbeDensidade.DataField  := 'BAS_PESPEC';
  dbeDescricao.DataField  := 'BAS_DESBAS';
  dbeEmbala.DataField     := 'BAS_EMBALA';
  dbeMargem.DataField     := 'BAS_MARGEM';
  dbePreCus.DataField     := 'BAS_PRECUS';
  dbePreVen.DataField     := 'BAS_PREVEN';
  dbeSistema.DataField    := 'BAS_MIXSCH';
end;

function TfrmCadAutBases.fCarregaDesIte(strCodIte: String): String;
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'SELECT ITE_DESITE FROM CADITE WHERE ITE_CODITE = "' + strCodIte + '"';
  qryGen.Open;
  Result := qryGen.FieldByName('ITE_DESITE').AsString;
  If fEmptyStr(Result) And Not fEmptyStr(strCodIte) Then
  Begin
    If dbeCodIte.Enabled Then
    Begin
      fMensagem('', 'Produto não encontrado!', ['OK']);
      pSetFocus(dbeCodIte);
    End;
  End;
  FreeAndNil(qryGen);
end;

procedure TfrmCadAutBases.btnPesquisaClick(Sender: TObject);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT  ';
  strSQL := strSQL + ' 	BAS_CODBAS "Base", ';
  strSQL := strSQL + ' 	BAS_DESBAS "Descrição", ';
  strSQL := strSQL + ' 	BAS_MIXSCH "Sistema", ';
  strSQL := strSQL + ' 	BAS_EMBALA "Embalagem", ';
  strSQL := strSQL + ' 	BAS_PESPEC "Peso Específico", ';
  strSQL := strSQL + ' 	ITE_CODITE "Código do Item", ';
  strSQL := strSQL + ' 	ITE_DESITE "Descrição do Item", ';
  strSQL := strSQL + ' 	ITE_REFERE "Referência do Item", ';
  strSQL := strSQL + ' 	B.AUTOINCREM "AUTOINCREM" ';
  strSQL := strSQL + ' FROM  ';
  strSQL := strSQL + ' 	AUT_CADBAS B ';
  strSQL := strSQL + ' 	LEFT JOIN CADITE I ON BAS_CODITE = ITE_CODITE ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + ' 	TRUE ';

  frmConsultaCompRelacionamento := TfrmConsultaCompRelacionamento.Create(Self);
  frmConsultaCompRelacionamento.strCampoRelacionamento := 'Código do Item';

  If pConsultaComp(Self, qryTabela, 'AUT_CADBAS', strSQL, stlCamInd, stlDesInd, '', False, frmConsultaCompRelacionamento) Then
  Begin
    dbeDesIte.Text := fCarregaDesIte(dbeCodIte.Text);
    pSetFocus(btnAlterar);
  End;

end;

procedure TfrmCadAutBases.dbeCodIteExit(Sender: TObject);
begin
  inherited;
  dbeDesIte.Text := fCarregaDesIte(dbeCodIte.Text);
end;

procedure TfrmCadAutBases.dbeCodIteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    stlCamIndIte: TStringList;
    stlDesIndIte: TStringList;
    strSQL: String;
    qryCadIte : TUniQuery;
begin

  If (fEntraCons(Key)) Then
  Begin

    Key := #0;
    stlCamIndIte := TStringList.Create;
    stlDesIndIte := TStringList.Create;
    qryCadIte :=  fCriaQuery(Self);

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
    //strSQL := strSQL + '  G.ITE_SALRES ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADITE I, ';
    strSQL := strSQL + '  ITEGER G, ';
    strSQL := strSQL + '  CADMAR M ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  G.ITE_IMPLIS = "S" AND ';
    strSQL := strSQL + '  I.ITE_CODMAR = M.MAR_CODMAR AND ';
    strSQL := strSQL + '  I.ITE_CODITE = G.ITE_CODITE AND ';
    strSQL := strSQL + '  G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';

    stlCamIndIte.Add('I.ITE_DESITE');
    stlCamIndIte.Add('I.ITE_CODITE');
    stlCamIndIte.Add('I.ITE_REFERE');
    stlCamIndIte.Add('I.ITE_CODBAR');

    stlDesIndIte.Add('Descrição');
    stlDesIndIte.Add('Codigo');
    stlDesIndIte.Add('Referência');

    utcRegistros.Limpar(Self.Name + 'CADITE');
    If pConsultaComp(Self, qryCadIte, 'CADITE', strSQL, stlCamIndIte, stlDesIndIte) Then
    Begin
      dbeCodIte.Text := qryCadIte.FieldByName('ITE_CODITE').AsString;
      dbeDesIte.Text := fCarregaDesIte(dbeCodIte.Text);
      btnRestPreco.Click;
      SelectNext(ActiveControl, True, True);
    End;

    FreeAndNil(qryCadIte);
    FreeAndNil(stlCamIndIte);
    FreeAndNil(stlDesIndIte);
  End;
end;

procedure TfrmCadAutBases.btnAlterarClick(Sender: TObject);
begin
  inherited;
  If qryTabela.State = dsEdit Then
  Begin
    pSetFocus(dbeDescricao);
    btnRestPreco.Visible := True;
  End;

  pHabilitaBtn;
end;

procedure TfrmCadAutBases.btnRestPrecoClick(Sender: TObject);
  Var
    fltPrecus: Double;
    fltMargem: Double;
    fltPreVen: Double;
begin
  inherited;
  pRetornaPrecos(dbeCodIte.Text, fltPrecus, fltMargem, fltPreVen);
  dbePreCus.Field.AsFloat := fltPrecus;
  dbeMargem.Field.AsFloat := fltMargem;
  dbePreVen.Field.AsFloat := fltPreVen;
end;

procedure TfrmCadAutBases.btnGravarClick(Sender: TObject);
begin
  inherited;
  btnRestPreco.Visible := False;
  pAtualizarFatorTintometrico;
end;

function TfrmCadAutBases.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = dbeDescricao) Then
    Begin
      If fEmptyStr(dbeDescricao.Text) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'A descrição deve ser preenchida', ['OK']);
      End;
    end

    Else If (Sender = dbeCodIte) Then
    Begin
      If Not fEmptyStr(dbeCodIte.Text) Then
      Begin
        If fExisteValorNoCampo(dbeCodIte.Text, 'BAS_CODITE', 'AUT_CADBAS', 'AUTOINCREM <> ' + QuotedStr(qryTabela.FieldByName('AUTOINCREM').AsString)) Then
        Begin
          Result := fMensagem('ATENÇÃO', 'Esse item já está relacionado a outra base!'#10#13'Deseja continuar ?', ['Sim', 'Não']) = 1;
        End;
      End;
    End

    Else If Not fEmptyStr(dbeCodIte.Text) Then
    Begin
      If (Sender = dbePreCus) Then
      Begin
        If (fEmptyStr(dbePreCus.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O preço de custo deve ser preenchido!', ['&Ok']);
          Result := False;
        End
        Else If (fStrToFloat(dbePreCus.Text) <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'O preço de custo deve maior que Zero!', ['&Ok']);
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
          fMensagem('ATENÇÃO!', 'O preço de venda deve ser preenchido!', ['&Ok']);
          Result := False;
        End
        Else If (fStrToFloat(dbePreVen.Text) <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'O preço de venda deve ser maior que Zero!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          dbeMargem.Field.AsFloat := fRetPrecoVenda(2);
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
    End

    Else If Sender = dbeDensidade Then
    Begin
      If (fEmptyStr(dbeDensidade.Text) or (fStrToFloat(dbeDensidade.Text) <= 0)) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'A densidade não está cadastrada corretamente', ['OK']);
      End;
    End

    Else If Sender = dbeEmbala Then
    Begin
      If (fEmptyStr(dbeEmbala.Text) or (fStrToFloat(dbeEmbala.Text) <= 0)) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'A embalagem não está cadastrada corretamente', ['OK']);
      End;
    End

//    Else If Sender = dbeDesIte Then
//    Begin
//      If (fEmptyStr(dbeDesIte.Text)) Then
//      Begin
//        Result := False;
//        fMensagem('ATENÇÃO!', 'O produto deve ser preenchido', ['OK']);
//      End;
//    End;

  end;

  If Not Result Then
    pSetFocus(Sender);

end;

function TfrmCadAutBases.fRetPrecoVenda(intOpcao: Integer): Double;
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

procedure TfrmCadAutBases.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  pSetFocus(dbeCodigo);
  pHabilitaBtn;
end;

procedure TfrmCadAutBases.pAtualizarFatorTintometrico;
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'UPDATE CADITE INNER JOIN AUT_CADBAS ON BAS_CODITE = ITE_CODITE SET ITE_CNV_ML = (BAS_EMBALA * BAS_PESPEC)';
  qryGen.ExecSQL;
  FreeAndNil(qryGen);
end;

end.





