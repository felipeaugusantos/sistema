unit untCadGerBases;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, Mask, DBCtrls, DBEditFocus, Uni, DB, EditFocus, UniClientDataSet;

type
  TfrmCadGerBases = class(TfrmPaiCad)
    pnlCampos: TPanel;
    pnlCabecalho: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    dbeCodigo: TDBEditFocus;
    dbeDescricao: TDBEditFocus;
    dbeOrdem: TDBEditFocus;
    dbePesEsp: TDBEditFocus;
    dbeEmbala: TDBEditFocus;
    dbeCusto: TDBEditFocus;
    dbeMargem: TDBEditFocus;
    dbeVenda: TDBEditFocus;
    Label9: TLabel;
    dbeItem: TDBEditFocus;
    edtDesIte: TEditFocus;
    btnRestPreco: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure dbeItemKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnRestPrecoClick(Sender: TObject);
  private
    { Private declarations }
    qryCadBas: TUniQuery;
    dtsCadBas: TDataSource;
    procedure pbtnRestPreco(DataSet: TDataSet);
  protected
    procedure pCriarDataSets;
    procedure pLigarDataSets;
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl;
      blnBuscaPorChave: Boolean = True): Boolean; override;

    procedure pCarregaItem;
  public
    { Public declarations }
  end;

var
  frmCadGerBases: TfrmCadGerBases;

implementation

uses untFuncoesSimples, untFuncTinta, untConsultaCompRelacionamento;

{$R *.dfm}

{ TfrmCadGerBases }

function TfrmCadGerBases.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If Sender = dbeCodigo Then
    Begin
      If fEmptyStr(dbeCodigo.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O Código deve ser preenchido!', ['OK']);
        Result := False;
      End;
    End
    Else If Sender = dbeDescricao Then
    Begin
      If fEmptyStr(dbeDescricao.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'A Descrição dever ser preenchida!', ['OK']);
        Result := False;
      End;
    End
    Else If Sender = dbeItem Then
    Begin
      If fEmptyStr(dbeItem.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O item deve ser preenchido!', ['OK']);
        Result := False;
      End
      Else
      Begin
        pCarregaItem;
        If fEmptyStr(edtDesIte.Text) Then
        Begin
          fMensagem('ATENÇÃO', 'O item não está cadastrado!', ['OK']);
          Result := False;
        End
        Else If fExisteValorNoCampo(dbeItem.Text, 'BAS_CODITE', 'GEN_CADBAS', 'AUTOINCREM <> ' + QuotedStr(qryTabela.FieldByName('AUTOINCREM').AsString)) Then
        Begin
          Result := fMensagem('ATENÇÃO', 'Esse item já está relacionado a outra base!'#10#13'Deseja continuar ?', ['Sim', 'Não'], 2) = 1;
        End;
      End;
    End
    Else If Sender = dbeOrdem Then
    Begin
      If fEmptyStr(dbeOrdem.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'A ordem deve ser preenchida!', ['OK']);
        Result := False;
      End
      Else If StrToIntDef(dbeOrdem.Text, 0) <= 0 Then
      Begin
        fMensagem('ATENÇÃO', 'A ordem deve ser maior que zero!', ['OK']);
        Result := False;
      End;
    End
    Else If Sender = dbePesEsp Then
    Begin
      If fEmptyStr(dbePesEsp.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O Peso específico deve ser preenchido!', ['OK']);
        Result := False;
      End
      Else If StrToFloat(dbePesEsp.Text) <= 0 Then
      Begin
        fMensagem('ATENÇÃO', 'O Peso específico deve ser maior que zero!', ['OK']);
        Result := False;
      End;
    End
    Else If Sender = dbeEmbala Then
    Begin
      If fEmptyStr(dbeEmbala.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'A embalagem deve ser preenchida!', ['OK']);
        Result := False;
      End
      Else If StrToFloat(dbeEmbala.Text) <= 0 Then
      Begin
        fMensagem('ATENÇÃO', 'A embalagem deve ser maior que zero!', ['OK']);
        Result := False;
      End;
    End
    Else If Sender = dbeCusto Then
    Begin
      If fEmptyStr(dbeCusto.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O custo deve ser preenchido!', ['OK']);
        Result := False;
      End
      Else If StrToFloat(dbeCusto.Text) <= 0 Then
      Begin
        fMensagem('ATENÇÃO', 'O custo deve ser maior que zero!', ['OK']);
        Result := False;
      End
      Else
      Begin
        dbeVenda.Field.AsFloat := fCalculaPrecoVenda(1,
                                                    StrToFloatDef(dbeCusto.Text, 0),
                                                    StrToFloatDef(dbeVenda.Text, 0),
                                                    StrToFloatDef(dbeMargem.Text, 0),
                                                    0.0,
                                                    0.0,
                                                    0.0);
      End;
    End
    Else If Sender = dbeMargem Then
    Begin
      If fEmptyStr(dbeMargem.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'A margem deve ser preenchida!', ['OK']);
        Result := False;
      End
      Else If StrToFloat(dbeMargem.Text) <= 0 Then
      Begin
        fMensagem('ATENÇÃO', 'A margem deve ser maior zero!', ['OK']);
        Result := False;
      End
      Else
      Begin
        dbeVenda.Field.AsFloat := fCalculaPrecoVenda(1,
                                                    StrToFloatDef(dbeCusto.Text, 0),
                                                    StrToFloatDef(dbeVenda.Text, 0),
                                                    StrToFloatDef(dbeMargem.Text, 0),
                                                    0.0,
                                                    0.0,
                                                    0.0);
      End;
    End
    Else If Sender = dbeVenda Then
    Begin
      If fEmptyStr(dbeVenda.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O preço de venda deve ser preenchido!', ['OK']);
        Result := False;
      End
      Else If StrToFloat(dbeVenda.Text) <= 0 Then
      Begin
        fMensagem('ATENÇÃO', 'O preço de venda deve ser maior que zero!', ['OK']);
        Result := False;
      End
      Else
      Begin
        dbeMargem.Field.AsFloat := fCalculaPrecoVenda(2,
                                                    StrToFloatDef(dbeCusto.Text, 0),
                                                    StrToFloatDef(dbeVenda.Text, 0),
                                                    StrToFloatDef(dbeMargem.Text, 0),
                                                    0.0,
                                                    0.0,
                                                    0.0);
      End;
    End;
  End;

  If Not Result Then
    Sender.SetFocus;

end;

procedure TfrmCadGerBases.pCriarDataSets;
begin
  qryCadBas := fCriarQuery('SELECT * FROM GEN_CADBAS', Self);

  qryCadBas.FieldByName('BAS_CODBAS').DisplayLabel := 'Código';
  qryCadBas.FieldByName('BAS_DESCRI').DisplayLabel := 'Descrição';
  TFloatField(qryCadBas.FieldByName('BAS_PESESP')).DisplayFormat := '0.0000';
  TFloatField(qryCadBas.FieldByName('BAS_EMBALA')).DisplayFormat := '0.0000';
  TFloatField(qryCadBas.FieldByName('BAS_PRECUS')).DisplayFormat := '0.00';
  TFloatField(qryCadBas.FieldByName('BAS_MARGEM')).DisplayFormat := '0.00';
  TFloatField(qryCadBas.FieldByName('BAS_PREVEN')).DisplayFormat := '0.00';
  qryCadBas.FieldByName('AUTOINCREM').Visible := False;
  qryCadBas.Open;

  qryCadBas.AfterEdit := pbtnRestPreco;
  qryCadBas.AfterPost := pbtnRestPreco;
  qryCadBas.AfterCancel := pbtnRestPreco;

  dtsCadBas := fCriaDataSource(qryCadBas); 
end;

procedure TfrmCadGerBases.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('BAS_CODBAS');
  stlCampos.Add('BAS_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('BAS_CODBAS');
  stlCamInd.Add('BAS_DESCRI');

  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');
end;

procedure TfrmCadGerBases.pLigarDataSets;
  Var
    intCont: Integer;
begin
  For intCont := 0 To ComponentCount - 1 Do
  Begin
    If Components[intCont] is TDBEdit Then
      TDBEdit(Components[intCont]).DataSource := dtsCadBas;
  End;

end;

procedure TfrmCadGerBases.FormCreate(Sender: TObject);
begin
  inherited;
  pCriarDataSets;
  pLigarDataSets;

  qryTabela := qryCadBas;
  strNomeTabela := 'GEN_CADBAS';
  strNomeCampo := 'BAS_CODBAS';

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

procedure TfrmCadGerBases.pCarregaItem;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery();
  qryGen.SQL.Text := 'SELECT ITE_DESITE FROM CADITE WHERE ITE_CODITE = :CODITE';
  qryGen.ParamByName('CODITE').AsString := dbeItem.Text;
  qryGen.Open;
  edtDesIte.Text := qryGen.FieldByName('ITE_DESITE').AsString;
  FreeAndNil(qryGen);
end;

procedure TfrmCadGerBases.btnPesquisaClick(Sender: TObject);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   B.AUTOINCREM, ';
  strSQL := strSQL + '   BAS_CODBAS      "Código", ';
  strSQL := strSQL + '   BAS_DESCRI      "Descrição", ';
  strSQL := strSQL + '   BAS_PESESP      "Peso Específico", ';
  strSQL := strSQL + '   BAS_EMBALA      "Embalagem", ';
  strSQL := strSQL + '   ITE_CODITE      "Código do Item", ';
  strSQL := strSQL + '   ITE_DESITE      "Descrição do Item", ';
  strSQL := strSQL + '   ITE_REFERE      "Referência do Item" ';
  strSQL := strSQL + ' FROM GEN_CADBAS B ';
  strSQL := strSQL + '   LEFT JOIN CADITE I ';
  strSQL := strSQL + '     ON B.BAS_CODITE = I.ITE_CODITE ';
  strSQL := strSQL + ' WHERE TRUE ';

  frmConsultaCompRelacionamento := TfrmConsultaCompRelacionamento.Create(Self);
  frmConsultaCompRelacionamento.strCampoRelacionamento := 'Código do Item';

  If pConsultaComp(Self, qryTabela, 'GEN_CADBAS', strSQL, stlCamInd, stlDesInd, '', False, frmConsultaCompRelacionamento) Then
  Begin
    pCarregaItem;
    If btnAlterar.CanFocus Then btnAlterar.SetFocus;
  End;
end;

procedure TfrmCadGerBases.dbeItemKeyPress(Sender: TObject; var Key: Char);
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
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADITE I, ';
    strSQL := strSQL + '  ITEGER G, ';
    strSQL := strSQL + '  CADMAR M ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  I.ITE_IMPLIS = "S" AND ';
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
      dbeItem.Text := qryCadIte.FieldByName('ITE_CODITE').AsString;
      pCarregaItem;
      btnRestPreco.Click;
      SelectNext(ActiveControl, True, True);
    End;

    FreeAndNil(qryCadIte);
    FreeAndNil(stlCamIndIte);
    FreeAndNil(stlDesIndIte);
  End;
end;

procedure TfrmCadGerBases.pbtnRestPreco(DataSet: TDataSet);
begin
  inherited;
  btnRestPreco.Visible := (dsEdit in [DataSet.State]) And Not fEmptyStr(edtDesIte.Text);
end;

procedure TfrmCadGerBases.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If dbeCodigo.CanFocus Then
    dbeCodigo.SetFocus;
end;

procedure TfrmCadGerBases.btnAlterarClick(Sender: TObject);
begin
  inherited;
  If dbeCodigo.CanFocus Then
    dbeCodigo.SetFocus;
end;

procedure TfrmCadGerBases.btnRestPrecoClick(Sender: TObject);
  Var
    fltPrecus: Double;
    fltMargem: Double;
    fltPreVen: Double;
begin
  inherited;
  pRetornaPrecos(dbeItem.Text, fltPrecus, fltMargem, fltPreVen);
  dbeCusto.Field.AsFloat := fltPrecus;
  dbeMargem.Field.AsFloat := fltMargem;
  dbeVenda.Field.AsFloat := fltPreVen;
end;

end.
