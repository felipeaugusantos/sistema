unit untCadMzaBases;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, Mask, DBCtrls, DBEditFocus, Uni, DB, EditFocus, UniClientDataSet,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadMzaBases = class(TfrmPaiCad)
    pnlCampos: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    dbeCodigo: TDBEditFocus;
    dbeDescricao: TDBEditFocus;
    dbePesEsp: TDBEditFocus;
    dbeEmbala: TDBEditFocus;
    dbeCusto: TDBEditFocus;
    dbeMargem: TDBEditFocus;
    dbeVenda: TDBEditFocus;
    Label9: TLabel;
    dbeItem: TDBEditFocus;
    edtDesIte: TEditFocus;
    btnRestPreco: TSpeedButton;
    lblLinha: TLabel;
    dbeLinha_: TDBEditFocus;
    edtDesLinha_: TEditFocus;
    dbeEfeito: TDBEditFocus;
    Label3: TLabel;
    pnlCabecalho: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure dbeItemKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnRestPrecoClick(Sender: TObject);
    procedure dbeLinha_KeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
  private
    { Private declarations }
    qryCadBas: TUniQuery;
    dtsCadBas: TDataSource;
    StrCodIteAnt : String;
    procedure pbtnRestPreco(DataSet: TDataSet);
    procedure pCarregarLinha;
    procedure pAtualizaFatorTintometrico;
    procedure pHabilitaBtn; 
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
  frmCadMzaBases: TfrmCadMzaBases;

implementation

uses untFuncoesSimples, untFuncTinta, untConsultas, untTypesSistema,
  untValidarBaseItemAmarracao;

{$R *.dfm}

{ TfrmCadGerBases }

function TfrmCadMzaBases.fValidaCampos(Sender: TWinControl;
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
      End;
    End
    Else If Sender = dbePesEsp Then
    Begin
      If fEmptyStr(dbePesEsp.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O Peso específico deve ser preenchido!', ['OK']);
        Result := False;
      End
      Else If fStrToFloat(dbePesEsp.Text) <= 0 Then
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
      Else If fStrToFloat(dbeEmbala.Text) <= 0 Then
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
      Else If fStrToFloat(dbeCusto.Text) <= 0 Then
      Begin
        fMensagem('ATENÇÃO', 'O custo deve ser maior que zero!', ['OK']);
        Result := False;
      End
      Else
      Begin
        dbeVenda.Field.AsFloat := fCalculaPrecoVenda(1,
                                                    fStrToFloat(dbeCusto.Text),
                                                    fStrToFloat(dbeVenda.Text),
                                                    fStrToFloat(dbeMargem.Text),
                                                    0.0,
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
      Else If fStrToFloat(dbeMargem.Text) <= 0 Then
      Begin
        fMensagem('ATENÇÃO', 'A margem deve ser maior zero!', ['OK']);
        Result := False;
      End
      Else
      Begin
        dbeVenda.Field.AsFloat := fCalculaPrecoVenda(1,
                                                    fStrToFloat(dbeCusto.Text),
                                                    fStrToFloat(dbeVenda.Text),
                                                    fStrToFloat(dbeMargem.Text),
                                                    0.0,
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
      Else If fStrToFloat(dbeVenda.Text) <= 0 Then
      Begin
        fMensagem('ATENÇÃO', 'O preço de venda deve ser maior que zero!', ['OK']);
        Result := False;
      End
      Else
      Begin
        dbeMargem.Field.AsFloat := fCalculaPrecoVenda(2,
                                                    fStrToFloat(dbeCusto.Text),
                                                    fStrToFloat(dbeVenda.Text),
                                                    fStrToFloat(dbeMargem.Text),
                                                    0.0,
                                                    0.0,
                                                    0.0,
                                                    0.0);
      End;
    End
    Else If Sender = dbeLinha_ Then
    Begin
      If fEmptyStr(dbeLinha_.Text) Then
      Begin
        Result := fMensagem('ATENÇÃO', 'A Linha deve ser escolhida!', ['OK']) = -1;
      End
      Else
      Begin
        pCarregarLinha;
        if fEmptyStr(edtDesLinha_.Text) then
          Result := fMensagem('ATENÇÃO', 'A Linha escolhida não é valida!', ['OK']) = -1;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmCadMzaBases.pCriarDataSets;
begin
  qryCadBas := fCriarQuery('SELECT * FROM MZA_CADBAS', Self);

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

procedure TfrmCadMzaBases.pHabilitaBtn;
begin
  dbePesEsp.ReadOnly := (qryTabela.State in [dsEdit]);
end;

procedure TfrmCadMzaBases.pInicializaIndices;
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

procedure TfrmCadMzaBases.pLigarDataSets;
  Var
    intCont: Integer;
begin
  For intCont := 0 To ComponentCount - 1 Do
  Begin
    If Components[intCont] is TDBEdit Then
      TDBEdit(Components[intCont]).DataSource := dtsCadBas;
  End;

end;

procedure TfrmCadMzaBases.FormCreate(Sender: TObject);
begin
  inherited;
  pCriarDataSets;
  pLigarDataSets;

  qryTabela     := qryCadBas;
  strNomeTabela := 'MZA_CADBAS';
  strNomeCampo  := 'BAS_CODBAS';

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

procedure TfrmCadMzaBases.pCarregaItem;
  Var
    qryMza: TUniQuery;
begin
  Try
    qryMza := fCriaQuery();
    qryMza.Close;
    qryMza.SQL.Clear;
    qryMza.SQL.Text := 'SELECT ITE_DESITE FROM CADITE WHERE ITE_CODITE = :CODITE';
    qryMza.ParamByName('CODITE').AsString := dbeItem.Text;
    qryMza.Open;
    
    edtDesIte.Text := qryMza.FieldByName('ITE_DESITE').AsString;
  Finally
    FreeAndNil(qryMza);
  End;
end;

procedure TfrmCadMzaBases.pCarregarLinha;
  Var
    qryMza: TUniQuery;
begin
  Try
    qryMza := fCriaQuery();
    qryMza.Close;
    qryMza.SQL.Clear;
    qryMza.SQL.Text := 'SELECT LIN_DESCRI FROM MZA_CADLIN WHERE LIN_CODIGO = :CODLIN';
    qryMza.ParamByName('CODLIN').AsString := dbeLinha_.Text;
    qryMza.Open;

    edtDesLinha_.Text := qryMza.FieldByName('LIN_DESCRI').AsString;
  Finally
    FreeAndNil(qryMza);
  End;
end;

procedure TfrmCadMzaBases.btnPesquisaClick(Sender: TObject);
  Var
    arrSel: TConsultasArray;
    Key: Char;
begin
  Key := '/';
  If fPesqBaseTinta(Self, conMza, nil, nil, qryTabela, Key, arrSel, True, '', '', False) Then
  Begin
    pCarregaItem;
    pCarregarLinha;
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadMzaBases.dbeItemKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  If fPesqItem(conIteSimples, Self, dbeItem, nil,  nil, Key, arrSel) Then
  Begin
    pCarregaItem;
    btnRestPreco.Click;
    SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadMzaBases.dbeLinha_KeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  If fPesqMZA_CADLIN(Self, TDBEdit(Sender), Nil, Key, arrSel) Then
  Begin
    pCarregarLinha;
    SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadMzaBases.pAtualizaFatorTintometrico;
begin
  fExecutaSQL(
    ' UPDATE                                                         ' +
    '   CADITE                                                       ' +
    '   INNER JOIN MZA_CADBAS                                        ' +
    '     ON ITE_CODITE = BAS_CODITE                                 ' +
    ' SET ITE_CNV_ML = IFNULL(BAS_PESESP, 1) * IFNULL(BAS_EMBALA, 1) ');
end;

procedure TfrmCadMzaBases.pbtnRestPreco(DataSet: TDataSet);
begin
  inherited;
  btnRestPreco.Visible := (dsEdit in [DataSet.State]) And Not fEmptyStr(edtDesIte.Text);
end;

procedure TfrmCadMzaBases.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCarregaItem;
  pCarregarLinha;
end;

procedure TfrmCadMzaBases.btnExcluirClick(Sender: TObject);
begin
  inherited;
  edtDesIte.Clear;
  edtDesLinha_.Clear;
end;

procedure TfrmCadMzaBases.btnExcluirClick(Sender: TObject);
begin
  strCodIteAnt := dbeItem.Text;
  inherited;

  If fEmptyStr(dbeItem) Then
    pEnviarLogRep(strCodIteAnt, 'MZA');

end;

procedure TfrmCadMzaBases.btnGravarClick(Sender: TObject);
Var
  ObjValidarBaseItemAmarracao : TValidarBaseItemAmarracao;
  blnEdit : Boolean;
begin
  ObjValidarBaseItemAmarracao := TValidarBaseItemAmarracao.Create;

  blnEdit := (qryCadBas.State in [dsEdit]);

  Try
    fStartTransaction;
    if ObjValidarBaseItemAmarracao.fValidarBaseItemAmarracao('MZA', dbeCodigo.text, dbeDescricao.text, dbeItem.Text , StrCodIteAnt ,
                                 qryCadBas.FieldByName('BAS_PESESP').AsFloat , strToFloat(dbeEmbala.Text)) Then
    begin
      inherited;
      pAtualizaFatorTintometrico;

      If (Not fEmptyStr(strCoditeAnt)) And (blnEdit) Then
      Begin
        If (strCoditeAnt <> dbeItem.Text) Then
          pEnviarLogRep(strCodIteAnt, 'MZA');
      End;

      fCommit;
    End
    Else
      fRollBack;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[btnGravarClick]');
    End;
  End;

  If Assigned(ObjValidarBaseItemAmarracao)Then
    FreeAndNil(ObjValidarBaseItemAmarracao);

end;

procedure TfrmCadMzaBases.btnIncluirClick(Sender: TObject);
begin
  strCodIteAnt := '';
  inherited;
  pSetFocus(dbeCodigo);
  edtDesIte.Clear;
  edtDesLinha_.Clear;
  pHabilitaBtn;
end;

procedure TfrmCadMzaBases.btnAlterarClick(Sender: TObject);
begin
  StrCodIteAnt := dbeItem.text;
  inherited;
  pSetFocus(dbeCodigo);
  pHabilitaBtn;
end;

procedure TfrmCadMzaBases.btnRestPrecoClick(Sender: TObject);
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



