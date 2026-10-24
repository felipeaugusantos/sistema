unit untCadMazBases;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, Mask, DBCtrls, DBEditFocus, EditFocus, Uni, DB,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadMazBases = class(TfrmPaiCad)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    btnRestPreco: TSpeedButton;
    pnlCabecalho: TPanel;
    edtDesIte: TEditFocus;
    dbeCodigo: TDBEditFocus;
    dbeDescricao: TDBEditFocus;
    dbeCodIte: TDBEditFocus;
    dbePreCus: TDBEditFocus;
    dbeMargem: TDBEditFocus;
    dbePreVen: TDBEditFocus;
    Label3: TLabel;
    dbeUnidade: TDBEditFocus;
    edtUnidade: TEditFocus;
    edtCodUni: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure dbeUnidadeExit(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure dbeUnidadeKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnRestPrecoClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    qryCadBas: TUniQuery;
    dtsCadBas: TDataSource;
    procedure pCriaDataSets;
    procedure pLigaDataSets;

    procedure pCarregaUnidade;
    procedure pCarregaItem;

    function fRetPrecoVenda(intOpcao: Integer): Double;
    procedure pbtnRestaura;
  public
    { Public declarations }
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmCadMazBases: TfrmCadMazBases;

implementation

uses untFuncoesSimples, untConsultaCompRelacionamento, untPai,
     untFuncTinta;

{$R *.dfm}

{ TfrmCadMazBases }

function TfrmCadMazBases.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If Sender = dbeCodigo Then
    Begin
      If fEmptyStr(dbeCodigo.Text) Then
        Result := (fMensagem('ATENÇÃO', 'O código da base deve ser informado!', ['OK']) = -1)
    End

    Else If Sender = dbeDescricao Then
    Begin
      If fEmptyStr(dbeDescricao.Text) Then
        Result := (fMensagem('ATENÇÃO', 'O Produto da base deve ser informada!', ['OK']) = -1);
    End

    Else If Sender = dbeUnidade Then
    Begin
      pCarregaUnidade;

      If fEmptyStr(dbeUnidade.Text) Then
      Begin
        Result := fMensagem('ATENÇÃO', 'A unidade deve ser preenchida!', ['OK']) = -1;
      End

      Else If fEmptyStr(edtUnidade.Text) Then
      Begin
        Result := fMensagem('ATENÇÃO', 'A unidade não é válida!', ['OK']) = -1;
      End;
    End

    Else If Not fEmptyStr(dbeCodIte.Text) Then
    Begin
      If Sender = dbeCodIte Then
      Begin
        pCarregaItem;

        If fEmptyStr(edtDesIte.Text) Then
        Begin
          Result := fMensagem('ATENÇÃO', 'O item não está cadastrado!', ['OK']) = -1;
        End
        Else If Not fItemAtivo(dbeCodIte.Text) Then
        Begin
          Result := fMensagem('ATENÇÃO', 'O item não está ativo', ['OK']) = -1;
        End
        Else If fExisteValorNoCampo(dbeCodIte.Text, 'BAS_CODITE', 'MAZ_CADBAS', 'AUTOINCREM <> ' + QuotedStr(qryTabela.FieldByName('AUTOINCREM').AsString)) Then
        Begin
          Result := fMensagem('ATENÇÃO', 'Esse item já está relacionado com outra base!'#10#13'Deseja Continuar?', ['Sim', 'Não']) = 1;
        End;
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

    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadMazBases.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('BAS_CODBAS+BAS_PRODUT+BAS_CODUNI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('BAS_CODBAS+BAS_PRODUT+BAS_CODUNI');

  stlDesInd.Add('Código/Produto/Unidade');
end;

procedure TfrmCadMazBases.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaDataSets;
  pLigaDataSets;

  qryTabela := qryCadBas;
  strNomeTabela := 'MAZ_CADBAS';
  strNomeCampo := 'BAS_CODBAS';

  SetLength(arrCamposChave, 2);
  arrCamposChave[0] := dbeCodigo;
  arrCamposChave[1] := dbeUnidade;
end;

procedure TfrmCadMazBases.pCriaDataSets;
begin

  qryCadBas := fCriarQuery('SELECT * FROM MAZ_CADBAS', Self);

  qryCadBas.FieldByName('BAS_CODBAS').DisplayLabel := 'Código';
  qryCadBas.FieldbyName('BAS_PRODUT').DisplayLabel := 'Produto';
  qryCadBas.FieldbyName('BAS_CODUNI').DisplayLabel := 'Unidade';
  qryCadBas.FieldByName('AUTOINCREM').Visible := False;

  TFloatField(qryCadBas.FieldByName('BAS_PRECUS')).DisplayFormat := '0.00';
  TFloatField(qryCadBas.FieldByName('BAS_PREVEN')).DisplayFormat := '0.00';
  TFloatField(qryCadBas.FieldByName('BAS_MARGEM')).DisplayFormat := '0.00';

  dtsCadBas := fCriaDataSource(qryCadBas);
end;

procedure TfrmCadMazBases.pLigaDataSets;
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
      (Components[intCont] as TDBEdit).DataSource := dtsCadBas;
    End;
  End;
end;

procedure TfrmCadMazBases.pCarregaUnidade;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery();
  qryGen.SQL.Text := 'SELECT UNI_DESUNI, UNI_SIGUNI FROM CADUNI WHERE UNI_CODUNI = :CODUNI';
  qryGen.ParamByName('CODUNI').AsString := dbeUnidade.Text;
  qryGen.Open;
  edtUnidade.Text := qryGen.FieldByName('UNI_DESUNI').AsString;
  edtCodUni.Text := qryGen.FieldByName('UNI_SIGUNI').AsString;
end;

procedure TfrmCadMazBases.dbeUnidadeExit(Sender: TObject);
begin
  inherited;
  pCarregaUnidade;
end;

procedure TfrmCadMazBases.btnPesquisaClick(Sender: TObject);
  Var
    strSql: String;
begin
  strSql := '';
  strSql := strSql + ' SELECT ';
  strSql := strSql + '   B.AUTOINCREM, ';
  strSql := strSql + '   BAS_CODBAS      "Código", ';
  strSql := strSql + '   BAS_PRODUT      "Produto", ';
  strSql := strSql + '   BAS_CODUNI      "Unidade", ';
  strSql := strSql + '   ITE_CODITE      "Código do Item", ';
  strSql := strSql + '   ITE_DESITE      "Descrição do Item", ';
  strSql := strSql + '   ITE_REFERE      "Referência" ';
  strSql := strSql + ' FROM MAZ_CADBAS B ';
  strSql := strSql + '   LEFT JOIN CADITE I ';
  strSql := strSql + '     ON B.BAS_CODITE = I.ITE_CODITE ';
  strSql := strSql + ' WHERE TRUE ';

  frmConsultaCompRelacionamento := TfrmConsultaCompRelacionamento.Create(Self);
  frmConsultaCompRelacionamento.strCampoRelacionamento := 'Código do Item';

  If pConsultaComp(Self, qryTabela, 'MAZ_CADBAS', strSql, stlCamInd, stlDesInd, '', False, frmConsultaCompRelacionamento) Then
  Begin
    pCarregaItem;
    pCarregaUnidade;
    pSetFocus(btnAlterar);
  End;


end;

procedure TfrmCadMazBases.pCarregaItem;
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

procedure TfrmCadMazBases.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pbtnRestaura;
  pSetFocus(dbeCodigo);
end;

function TfrmCadMazBases.fRetPrecoVenda(intOpcao: Integer): Double;
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

procedure TfrmCadMazBases.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  
  pSetFocus(dbeCodigo);
end;

procedure TfrmCadMazBases.dbeUnidadeKeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryCadUni: TUniQuery;

    stlCamposCon: TStringList;
    stlCamIndCon: TStringList;
    stlDesIndCon: TStringList;
begin
  inherited;
  stlCamposCon := TStringList.Create;
  stlCamIndCon := TStringList.Create;
  stlDesIndCon := TStringList.Create;

  If fEntraCons(Key) Then
  Begin
    Key := #0;

    stlCamposCon.Add('UNI_CODUNI');
    stlCamposCon.Add('UNI_DESUNI');    
    stlCamposCon.Add('UNI_SIGUNI');
    stlCamposCon.Add('AUTOINCREM');

    stlCamIndCon.Add('UNI_DESUNI');
    stlCamIndCon.Add('UNI_SIGUNI');
    stlCamIndCon.Add('UNI_CODUNI');

    stlDesIndCon.Add('Descrição');
    stlDesIndCon.Add('Sigla');
    stlDesIndCon.Add('Código');

    qryCadUni := fCriarQuery('SELECT * FROM CADUNI');

    qryCadUni.FieldByName('AUTOINCREM').Visible := False;
    qryCadUni.FieldByName('UNI_DESUNI').DisplayLabel := 'Descrição';
    qryCadUni.FieldByName('UNI_SIGUNI').DisplayLabel := 'Sigla';
    qryCadUni.FieldByName('UNI_CODUNI').DisplayLabel := 'Código';

    If pConsultaRapida(Self, qryCadUni, 'CADUNI',
        stlCamIndCon, stlDesIndCon, stlCamposCon) Then
    Begin
      dbeUnidade.Text := qryCadUni.FieldByName('UNI_CODUNI').AsString;
      pCarregaUnidade;
      SelectNext(ActiveControl, True, True);
      fValidaCampos(dbeUnidade, True);
    End;

    FreeAndNil(qryCadUni);
  End;

  FreeAndNil(stlCamposCon);
  FreeAndNil(stlCamIndCon);
  FreeAndNil(stlDesIndCon);

end;

procedure TfrmCadMazBases.dbeCodIteKeyPress(Sender: TObject;
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

    utcRegistros.Limpar(Self.Name + TDBEdit(Sender).Name + 'CADITE');
    If pConsultaComp(Self, qryCadIte, 'CADITE', strSQL, stlCamIndIte, stlDesIndIte) Then
    Begin
      TDBEdit(Sender).Text := qryCadIte.FieldByName('ITE_CODITE').AsString;
      pCarregaItem;
      btnRestPreco.Click;
      SelectNext(ActiveControl, True, True);
    End;

    FreeAndNil(qryCadIte);
    FreeAndNil(stlCamIndIte);
    FreeAndNil(stlDesIndIte);
  End;
end;

procedure TfrmCadMazBases.pbtnRestaura;
begin
  btnRestPreco.Visible := qryCadBas.State = dsEdit;
end;

procedure TfrmCadMazBases.btnGravarClick(Sender: TObject);
begin
  inherited;
  pbtnRestaura;
end;

procedure TfrmCadMazBases.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pbtnRestaura;
end;

procedure TfrmCadMazBases.btnRestPrecoClick(Sender: TObject);
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

procedure TfrmCadMazBases.btnExcluirClick(Sender: TObject);
begin
  inherited;
  pbtnRestaura;
end;

end.

