unit untCadMazColorantes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, Mask, DBCtrls, DBEditFocus, EditFocus, Uni, DB,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadMazColorantes = class(TfrmPaiCad)
    Panel1: TPanel;
    Label1: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    btnRestPreco: TSpeedButton;
    pnlCabecalho: TPanel;
    edtDesIte: TEditFocus;
    dbeCodigo: TDBEditFocus;
    dbeCodIte: TDBEditFocus;
    dbePreCus: TDBEditFocus;
    dbeMargem: TDBEditFocus;
    dbePreVen: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnRestPrecoClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
  private
    qryCadCol: TUniQuery;
    dtsCadCol: TDataSource;
    procedure pCriaDataSets;
    procedure pLigaDataSets;
    procedure pbtnRestaura;
    procedure pCarregaItem;
    procedure pAtualizaFatorTintometrico;
    function fRetPrecoVenda(intOpcao: Integer): Double;
  public
    { Public declarations }
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmCadMazColorantes: TfrmCadMazColorantes;

implementation

uses untFuncoesSimples, untFuncTinta, untConsultaCompRelacionamento;

{$R *.dfm}

{ TfrmCadMazColorantes }

function TfrmCadMazColorantes.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If Sender = dbeCodigo Then
    Begin
      If fEmptyStr(dbeCodigo.Text) Then
        Result := fMensagem('ATENÇÃO', 'O código do colorante deve ser preenchido!', ['OK']) = -1;
    End

    Else If Not fEmptyStr(dbeCodIte.Text) Then
    Begin
      pCarregaItem;

      If Sender = dbeCodIte Then
      Begin
        If fEmptyStr(edtDesIte.Text) Then
          Result := fMensagem('ATENÇÃO', 'O item não está cadastrado!', ['OK']) = -1
        Else If Not fItemAtivo(dbeCodIte.Text) Then
          Result := fMensagem('ATENÇÃO', 'O item não está ativo!', ['OK']) = -1
        Else If fExisteValorNoCampo(dbeCodIte.Text, 'COL_CODITE', 'MAZ_CADCOL', 'AUTOINCREM <> ' + QuotedStr(qryTabela.FieldByName('AUTOINCREM').AsString)) Then
          Result := fMensagem('ATENÇÃO', 'Esse item já está relacionado com outro colorante!'#10#13'Deseja Continuar?', ['Sim', 'Não']) = 1;
      End

      Else If Sender = dbePreCus Then
      Begin
        If fEmptyStr(dbePreCus.Text) Then
        Begin
          Result := fMensagem('ATENÇÃO', 'O preço de custos deve ser preenchido!', ['OK']) = -1;
        End
        Else If fStrToFloat(dbePreCus.Text) <= 0 Then
        Begin
          Result := fMensagem('ATENÇÃO', 'O preço de custo deve ser maior que zero!', ['OK']) = -1;
        End
        Else
          dbePreVen.Field.AsFloat := fRetPrecoVenda(1);
      End
      
      Else If Sender = dbePreVen Then
      Begin
        If fEmptyStr(dbePreVen.Text) Then
        Begin
          Result := fMensagem('ATENÇÃO', 'O preço de venda deve ser preenchido!', ['OK']) = -1;
        End
        Else If fStrToFloat(dbePreVen.Text) <= 0 Then
        Begin
          Result := fMensagem('ATENÇÃO', 'O preço de venda deve ser maior que zero!', ['OK']) = -1;
        End
        Else
          dbeMargem.Field.AsFloat := fRetPrecoVenda(2);
      End

      Else If Sender = dbeMargem Then
      Begin
        If fEmptyStr(dbeMargem.Text) Then
        Begin
          Result := fMensagem('ATENÇÃO', 'A margem deve ser preenchida!', ['OK']) = -1;
        End
        Else If fStrToFloat(dbeMargem.Text) <= 0 Then
        Begin
          Result := fMensagem('ATENÇÃO', 'A margem deve ser maior que zero!', ['OK']) = -1;
        End
        Else
          dbePreVen.Field.AsFloat := fRetPrecoVenda(1);
      End

    End

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadMazColorantes.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('COL_CODCOL');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('COL_CODCOL');

  stlDesInd.Add('Código');
end;

procedure TfrmCadMazColorantes.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaDataSets;
  pLigaDataSets;

  qryTabela := qryCadCol;
  strNomeTabela := 'MAZ_CADCOL';
  strNomeCampo := 'COL_CODCOL';

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

procedure TfrmCadMazColorantes.pCriaDataSets;
begin

  qryCadCol := fCriarQuery('SELECT * FROM MAZ_CADCOL', Self);

  qryCadCol.FieldByName('COL_CODCOL').DisplayLabel := 'Código';
  qryCadCol.FieldByName('AUTOINCREM').Visible := False;

  TFloatField(qryCadCol.FieldByName('COL_PRECUS')).DisplayFormat := '0.00';
  TFloatField(qryCadCol.FieldByName('COL_PREVEN')).DisplayFormat := '0.00';
  TFloatField(qryCadCol.FieldByName('COL_MARGEM')).DisplayFormat := '0.00';

  dtsCadCol := fCriaDataSource(qryCadCol);
end;

procedure TfrmCadMazColorantes.pLigaDataSets;
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
      (Components[intCont] as TDBEdit).DataSource := dtsCadCol;
    End;
  End;
end;

procedure TfrmCadMazColorantes.btnRestPrecoClick(Sender: TObject);
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

procedure TfrmCadMazColorantes.pAtualizaFatorTintometrico;
begin
  fExecutaSQL(
    ' UPDATE                         ' +
    '   CADITE                       ' +
    '   INNER JOIN MAZ_CADCOL        ' +
    '     ON ITE_CODITE = COL_CODITE ' +
    ' SET ITE_CNV_ML = 946           ');
end;

procedure TfrmCadMazColorantes.pbtnRestaura;
begin
  btnRestPreco.Visible := qryCadCol.State = dsEdit;
end;

procedure TfrmCadMazColorantes.btnGravarClick(Sender: TObject);
begin
  inherited;
  pbtnRestaura;
  pAtualizaFatorTintometrico;
end;

procedure TfrmCadMazColorantes.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pSetFocus(dbeCodigo);
  pbtnRestaura;
end;

procedure TfrmCadMazColorantes.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pbtnRestaura;
end;

procedure TfrmCadMazColorantes.btnExcluirClick(Sender: TObject);
begin
  inherited;
  pbtnRestaura;
end;

procedure TfrmCadMazColorantes.dbeCodIteKeyPress(Sender: TObject;
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
      pCarregaItem;
      btnRestPreco.Click;
      SelectNext(ActiveControl, True, True);
    End;

    FreeAndNil(qryCadIte);
    FreeAndNil(stlCamIndIte);
    FreeAndNil(stlDesIndIte);
  End;
end;

procedure TfrmCadMazColorantes.pCarregaItem;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery();
  qryGen.SQL.Text := 'SELECT ITE_DESITE FROM CADITE WHERE ITE_CODITE = :CODITE';
  qryGen.ParamByName('CODITE').AsString := dbeCodIte.Text;
  qryGen.Open;
  edtDesIte.Text := qryGen.FieldByName('ITE_DESITE').AsString;
  FreeAndNil(qryGen);
end;

function TfrmCadMazColorantes.fRetPrecoVenda(intOpcao: Integer): Double;
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

procedure TfrmCadMazColorantes.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  
  pSetFocus(dbeCodigo);
end;

procedure TfrmCadMazColorantes.btnPesquisaClick(Sender: TObject);
  Var
    strSql: String;
begin
  strSql := '';
  strSql := strSql + ' SELECT ';
  strSql := strSql + '   MAZ_CADCOL.AUTOINCREM, ';
  strSql := strSql + '   COL_CODCOL               "Código", ';
  strSql := strSql + '   ITE_CODITE               "Código do Item", ';
  strSql := strSql + '   ITE_DESITE               "Descrição", ';
  strSql := strSql + '   ITE_REFERE               "Referência" ';
  strSql := strSql + ' FROM MAZ_CADCOL ';
  strSql := strSql + '   LEFT JOIN CADITE ';
  strSql := strSql + '     ON COL_CODITE = ITE_CODITE ';
  strSql := strSql + ' WHERE TRUE ';

  frmConsultaCompRelacionamento := TfrmConsultaCompRelacionamento.Create(Self);
  frmConsultaCompRelacionamento.strCampoRelacionamento := 'Código do Item';

  If pConsultaComp(Self, qryTabela, 'MAZ_CADCOL', strSql, stlCamInd, stlDesInd, '', False, frmConsultaCompRelacionamento) Then
  Begin
    pCarregaItem;
    pSetFocus(btnAlterar);
  End;

end;

end.

