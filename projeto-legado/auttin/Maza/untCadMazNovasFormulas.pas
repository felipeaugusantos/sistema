unit untCadMazNovasFormulas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, Mask, DBCtrls, DBEditFocus, Uni, DB, EditFocus,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadMazNovasFormulas = class(TfrmPaiCad) 
    pnlCentral: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    Label8: TLabel;
    Label7: TLabel;
    Label16: TLabel;
    Label15: TLabel;
    Label14: TLabel;
    Label13: TLabel;
    Label12: TLabel;
    Label11: TLabel;
    Label10: TLabel;
    Label17: TLabel;
    pnlCabecalho: TPanel;
    dbeBase1: TDBEditFocus;
    dbeUnidade: TDBEditFocus;
    dbeForm01: TDBEditFocus;
    dbeQtd01: TDBEditFocus;
    dbeQtd03: TDBEditFocus;
    dbeForm03: TDBEditFocus;
    dbeQtd02: TDBEditFocus;
    dbeForm02: TDBEditFocus;
    dbeQtd06: TDBEditFocus;
    dbeForm06: TDBEditFocus;
    dbeQtd05: TDBEditFocus;
    dbeForm05: TDBEditFocus;
    dbeQtd04: TDBEditFocus;
    dbeForm04: TDBEditFocus;
    dbeCodigo: TDBEditFocus;
    lblInformacao: TLabel;
    lblDescri: TLabel;
    dbeDescri: TDBEditFocus;
    lblProdut: TLabel;
    dbeProdut: TDBEditFocus;
    procedure btnGravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbeBase1KeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure dbeForm01KeyPress(Sender: TObject; var Key: Char);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    qryCadNfm: TUniQuery;
    dtsCadNfm: TDataSource;
  protected
    procedure pCriarDataSets;
    procedure pLigarDataSets;
    procedure pInicializaIndices; override;
    function fValidaBase(strcodBas: String): Boolean;
    function fValidaCol(strCodCol: String): Boolean;
    function fValidaCampos(Sender: TWinControl;
      blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCadMazNovasFormulas: TfrmCadMazNovasFormulas;

implementation

uses untFuncoesSimples, untIConfTinta,
     untFuncTinta,StrUtils, untMaza;

{$R *.dfm}

procedure TfrmCadMazNovasFormulas.btnGravarClick(Sender: TObject);
  Var
    blnInsert: Boolean;
    strNfm: String;
    conf: IConfTinta;
begin
  conf      := fGetConfTinta('MAZ');
  qryTabela := qryCadNfm;
  blnInsert := (qryTabela.State = dsInsert);
  If (blnInsert) Then
  Begin
    strNfm :=  conf.fGet('NFMMAZ'); //fArqIniTinta(0, 'MAZA', 'NFMMAZ', '0');
    qryTabela.FieldByName('NFM_COLNUM').AsString := 'ESP ' + fStrZero(strNfm, 5);    
  End;
  fStartTransaction;
  inherited;
  Try
    If (blnGravou) Then
    Begin
      Screen.Cursor := crHourGlass;
      If TMaza.fGravarNovaFormula(qryCadNfm) Then
      Begin
        If (blnInsert) Then
        Begin
          conf.pSet('NFMMAZ', fStrZero(StrToInt(strNfm) + 1, 5)); //fArqIniTinta(1, 'MAZA', 'NFMMAZ', fStrZero(StrToInt(strNfm) + 1, 5));
        End;

        fCommit;
      End
      Else
        fRollBack;

      Screen.Cursor := crDefault;
      blnGravou := False;
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
end;

procedure TfrmCadMazNovasFormulas.pCriarDataSets;
  Var
    intCont: Integer;
begin
  qryCadNfm := fCriarQuery('SELECT * FROM MAZ_CADNFM');

  qryCadNfm.FieldByName('NFM_COLNUM').DisplayLabel := 'Código';
  qryCadNfm.FieldByName('NFM_PRODUT').DisplayLabel := 'Produto';
  qryCadNfm.FieldByName('NFM_COLNAM').DisplayLabel := 'Descrição';
  qryCadNfm.FieldByName('NFM_CODBAS').DisplayLabel := 'Base';
  qryCadNfm.FieldByName('NFM_CODUNI').DisplayLabel := 'Unidade';

  qryCadNfm.FieldByName('AUTOINCREM').Visible := False;

  For intCont := 1 To 10 Do
  Begin
    TFloatField(qryCadNfm.FieldByName('NFM_QTDC' + fStrZero(intCont, 2))).DisplayFormat := '0.000';
  End;

  dtsCadNfm := fCriaDataSource(qryCadNfm);
end;

procedure TfrmCadMazNovasFormulas.pLigarDataSets;
  Var
    intCont: Integer;
begin
    For intCont := 0 To ComponentCount - 1 Do
    Begin
      If (Components[intCont] is TDBEdit) Then
      Begin
        (Components[intCont] as TDBEdit).DataSource := dtsCadNfm;
      End;
    End;
end;

procedure TfrmCadMazNovasFormulas.FormCreate(Sender: TObject);
begin
  inherited;
  pCriarDataSets;
  pLigarDataSets;

  qryTabela := qryCadNfm;
  strNomeTabela := 'MAZ_CADNFM';
  strNomeCampo := 'NFM_COLNUM';

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

function TfrmCadMazNovasFormulas.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If inherited fValidaCampos(Sender, blnBuscaPorChave) Then
  Begin
    If Sender = dbeDescri Then
    Begin
      If fEmptyStr(dbeDescri.Text) Then
      Begin
         Result :=  fMensagem('ATENÇÃO', 'A descrição deve ser preenchida!', ['OK']) = -1;
      End;
    End
    Else If Sender = dbeBase1 Then
    Begin
      If fEmptyStr(dbeBase1.Text) Then
      Begin
        Result := fMensagem('ATENÇÃO', 'Uma base deve ser escolhida!', ['OK']) = -1;
      End;              
    End
    Else If Pos('dbeForm', Sender.Name) > 0 Then
    Begin
      If Sender = dbeForm01 Then
      Begin
        If fEmptyStr(dbeForm01.Text) Then
        Begin
          Result := fMensagem('ATENÇÃO', 'Pelo menos um colorante deve ser preenchido!', ['OK']) = -1;
        End
        Else If Not fValidaCol(dbeForm01.Text) Then
        Begin
          Result := fMensagem('ATENÇÃO', 'O colorante não é válido!', ['OK']) = -1;
        End;
      End
      Else If Not (fEmptyStr(TDBEdit(Sender).Text)) Then
      Begin
        If Not fValidaCol(TDBEdit(Sender).Text) Then
        Begin
          Result := fMensagem('ATENÇÃO', 'O colorante não é válido!', ['OK']) = -1;
        End;
      End;
    End
    Else If Pos('dbeQtd', Sender.Name) > 0 Then
    Begin
      If Not fEmptyStr(TDBEdit(FindComponent('dbeForm' + RightStr(Sender.Name, 2))).Text) Then
      Begin
        If fEmptyStr(TDBEdit(Sender).Text) Then
        Begin
          Result := fMensagem('ATENÇÃO', 'A quantidade deve ser preenchida!', ['OK']) = -1;
        End
        Else If fStrToFloat(TDBEdit(Sender).Text) <= 0 Then
        Begin
          Result := fMensagem('ATENÇÃO', 'A quantidade deve ser maior que zero!', ['OK']) = -1;
        End;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadMazNovasFormulas.pInicializaIndices;
begin
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('NFM_COLNUM');
  stlCampos.Add('NFM_COLNAM+NFM_PRODUT+NFM_CODBAS');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('NFM_COLNUM');
  stlCamInd.Add('NFM_COLNAM+NFM_PRODUT+NFM_CODBAS');

  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição/Produto/Base');
end;


procedure TfrmCadMazNovasFormulas.dbeBase1KeyPress(Sender: TObject;
  var Key: Char);
  Var
    stlCamInd: TStringList;
    stlDesInd: TStringList;
    strSQL: String;
    qryGen : TUniQuery;
begin
  If (fEntraCons(Key)) Then
  Begin
    Key := #0;
    stlCamInd := TStringList.Create;
    stlDesInd := TStringList.Create;
    qryGen :=  fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   BAS_CODBAS               "Base", ';
    strSQL := strSQL + '   BAS_PRODUT               "Produto", ';
    strSQL := strSQL + '   BAS_CODUNI               "Unidade", ';
    strSQL := strSQL + '   ITE_CODITE               "Código do Item", ';
    strSQL := strSQL + '   ITE_DESITE               "Descrição do Item", ';
    strSQL := strSQL + '   ITE_REFERE               "Referência do Item", ';
    strSQL := strSQL + '   MAZ_CADBAS.AUTOINCREM ';
    strSQL := strSQL + ' FROM MAZ_CADBAS ';
    strSQL := strSQL + '   LEFT JOIN CADITE ';
    strSQL := strSQL + '     ON BAS_CODITE = ITE_CODITE ';
    strSQL := strSQL + ' WHERE BAS_CODUNI = "QT" ';

    stlCamInd.Add('BAS_CODBAS+BAS_PRODUT');
    stlCamInd.Add('ITE_DESITE');
    stlCamInd.Add('ITE_CODITE');

    stlDesInd.Add('Base/Produto');
    stlDesInd.Add('Descrição do Item');
    stlDesInd.Add('Código Item');

    utcRegistros.Limpar(Self.Name + TDBEdit(Sender).Name + 'MAZ_CADBAS');
    If pConsultaComp(Self, qryGen, 'MAZ_CADBAS', strSQL, stlCamInd, stlDesInd) Then
    Begin
      dbeBase1.Field.AsString := qryGen.FieldByName('BAS_CODBAS').AsString;
      dbeProdut.Field.AsString := qryGen.FieldByName('BAS_PRODUT').AsString;
      SelectNext(ActiveControl, True, True);
    End;

    FreeAndNil(qryGen);
    FreeAndNil(stlCamInd);
    FreeAndNil(stlDesInd);
  End;
end;

procedure TfrmCadMazNovasFormulas.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  
  dbeUnidade.Field.AsString := 'QT';
  If dbeBase1.CanFocus Then
    pSetFocus(dbeBase1);
end;

procedure TfrmCadMazNovasFormulas.dbeForm01KeyPress(Sender: TObject;
  var Key: Char);
  Var
    stlCamInd: TStringList;
    stlDesInd: TStringList;
    strSQL: String;
    qryGen : TUniQuery;
begin

  If (fEntraCons(Key)) Then
  Begin

    Key := #0;
    stlCamInd := TStringList.Create;
    stlDesInd := TStringList.Create;
    qryGen :=  fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   COL_CODCOL               "Código", ';
    strSQL := strSQL + '   ITE_CODITE               "Código do Item", ';
    strSQL := strSQL + '   ITE_DESITE               "Descrição do Item", ';
    strSQL := strSQL + '   ITE_REFERE               "Referência", ';
    strSQL := strSQL + '   MAZ_CADCOL.AUTOINCREM ';
    strSQL := strSQL + ' FROM MAZ_CADCOL ';
    strSQL := strSQL + '   LEFT JOIN CADITE ';
    strSQL := strSQL + '     ON COL_CODITE = ITE_CODITE ';
    strSQL := strSQL + ' WHERE TRUE ';

    stlCamInd.Add('COL_CODCOL');
    stlCamInd.Add('ITE_CODITE');
    stlCamInd.Add('ITE_DESITE');

    stlDesInd.Add('Código');
    stlDesInd.Add('Código do Item');
    stlDesInd.Add('Descrição do Item');

    utcRegistros.Limpar(Self.Name + TDBEdit(Sender).Name + 'MAZ_CADCOL');
    If pConsultaComp(Self, qryGen, 'MAZ_CADCOL', strSQL, stlCamInd, stlDesInd) Then
    Begin
      TDBEdit(Sender).Field.AsString := qryGen.FieldByName('COL_CODCOL').AsString;
      SelectNext(ActiveControl, True, True);
    End;

    FreeAndNil(qryGen);
    FreeAndNil(stlCamInd);
    FreeAndNil(stlDesInd);
  End;
end;

function TfrmCadMazNovasFormulas.fValidaBase(strcodBas: String): Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery();
  qryGen.SQL.Add(' SELECT ');
  qryGen.SQL.Add('   COUNT(*)    QTD ');
  qryGen.SQL.Add(' FROM MAZ_CADBAS ');
  qryGen.SQL.Add(' WHERE BAS_CODBAS = :CODBAS ');
  qryGen.SQL.Add('     AND BAS_CODUNI = "QT" ');

  qryGen.ParamByName('CODBAS').AsString := strcodBas;
  qryGen.Open;

  Result := qryGen.FieldByName('QTD').AsInteger > 0;
  FreeAndNil(qryGen);
end;

function TfrmCadMazNovasFormulas.fValidaCol(strCodCol: String): Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery();
  qryGen.SQL.Add(' SELECT ');
  qryGen.SQL.Add('   COUNT(*)    QTD ');
  qryGen.SQL.Add(' FROM MAZ_CADCOL ');
  qryGen.SQL.Add(' WHERE COL_CODCOL = :CODCOL ');

  qryGen.ParamByName('CODCOL').AsString := strCodCol;
  qryGen.Open;

  Result := qryGen.FieldByName('QTD').AsInteger > 0;
  FreeAndNil(qryGen);
end;

procedure TfrmCadMazNovasFormulas.btnExcluirClick(Sender: TObject);
  Var
    strCodigo: String;
begin
  strCodigo := qryCadNfm.FieldbyName('NFM_COLNUM').AsString;
  fStartTransaction;
  inherited;
  Try
    If blnExcluiu Then
    Begin
      TMaza.pDeletarNovaFormula(strCodigo);
      fCommit;
    End
    Else
      fRollBack;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[btnExcluirClick]');
    End;
  End;
end;

initialization
  RegisterClass(TfrmCadMazNovasFormulas);
finalization
  UnRegisterClass(TfrmCadMazNovasFormulas);

end.

