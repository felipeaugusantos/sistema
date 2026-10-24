unit untCadAleNovasFormulas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, StdCtrls, Mask, DBCtrls, DBEditFocus, AppEvnts, Menus,
  ComCtrls, Buttons, ExtCtrls, StrUtils, Uni, DB,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadAleNovasFormulas = class(TfrmPaiCad)
    pnlCentral: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    Label8: TLabel;
    Label7: TLabel;
    Label12: TLabel;
    Label11: TLabel;
    Label10: TLabel;
    pnlCabecalho: TPanel;
    lblNomeLong: TLabel;
    lblCodigo: TLabel;
    lblYQtd1: TLabel;
    lblYQtd02: TLabel;
    lblYQtd03: TLabel;
    lblYQtd04: TLabel;
    lblCol5: TLabel;
    lblQtd5: TLabel;
    lblY5: TLabel;
    lblForm6: TLabel;
    lblQtd6: TLabel;
    lblY6: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    dbeCodigo: TDBEditFocus;
    dbeNomCor: TDBEditFocus;
    dbeNomLong: TDBEditFocus;
    dbeProdut: TDBEditFocus;
    dbeBase: TDBEditFocus;
    dbeCodUni: TDBEditFocus;
    dbeForm01: TDBEditFocus;
    dbeQtd01: TDBEditFocus;
    dbeQtdf01: TDBEditFocus;
    dbeForm02: TDBEditFocus;
    dbeQtd02: TDBEditFocus;
    dbeQtdf02: TDBEditFocus;
    dbeForm03: TDBEditFocus;
    dbeQtd03: TDBEditFocus;
    dbeQtdf03: TDBEditFocus;
    dbeForm04: TDBEditFocus;
    dbeQtd04: TDBEditFocus;
    dbeQtdf04: TDBEditFocus;
    dbeForm05: TDBEditFocus;
    dbeQtd05: TDBEditFocus;
    dbeQtdf05: TDBEditFocus;
    dbeForm06: TDBEditFocus;
    dbeQtd06: TDBEditFocus;
    dbeQtdf06: TDBEditFocus;
    dbeForm07: TDBEditFocus;
    dbeQtd07: TDBEditFocus;
    dbeQtdf07: TDBEditFocus;
    dbeForm08: TDBEditFocus;
    dbeQtd08: TDBEditFocus;
    dbeQtdf08: TDBEditFocus;
    dbeForm09: TDBEditFocus;
    dbeQtd09: TDBEditFocus;
    dbeQtdf09: TDBEditFocus;
    dbeForm10: TDBEditFocus;
    dbeQtd10: TDBEditFocus;
    dbeQtdf10: TDBEditFocus;
    dbeForm11: TDBEditFocus;
    dbeQtd11: TDBEditFocus;
    dbeQtdf11: TDBEditFocus;
    dbeForm12: TDBEditFocus;
    dbeQtd12: TDBEditFocus;
    dbeQtdf12: TDBEditFocus;
    dbeForm13: TDBEditFocus;
    dbeQtd13: TDBEditFocus;
    dbeQtdf13: TDBEditFocus;
    dbeForm14: TDBEditFocus;
    dbeQtd14: TDBEditFocus;
    dbeQtdf14: TDBEditFocus;
    dbeForm15: TDBEditFocus;
    dbeQtd15: TDBEditFocus;
    dbeQtdf15: TDBEditFocus;
    dbeForm16: TDBEditFocus;
    dbeQtd16: TDBEditFocus;
    dbeQtdf16: TDBEditFocus;
    dbeForm17: TDBEditFocus;
    dbeQtd17: TDBEditFocus;
    dbeQtdf17: TDBEditFocus;
    dbeForm18: TDBEditFocus;
    dbeQtd18: TDBEditFocus;
    dbeQtdf18: TDBEditFocus;
    dbeForm19: TDBEditFocus;
    dbeQtd19: TDBEditFocus;
    dbeQtdf19: TDBEditFocus;
    dbeForm20: TDBEditFocus;
    dbeQtd20: TDBEditFocus;
    dbeQtdf20: TDBEditFocus;
    Label55: TLabel;
    dbeDtaCad: TDBEditFocus;
    procedure dbeProdutKeyPress(Sender: TObject; var Key: Char);
    procedure dbeForm04KeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
  private
    { Private declarations }
    qryCadNfm: TUniQuery;
    dtsCadNfm: TDataSource;
    procedure pCriaDataSets;
    procedure pLigaDataSets;
    function fValidaColorante(strCol: String): Boolean;
    function fValidaProduto(strProd: String): Boolean;
    function fValidaBase(strBas: String): Boolean;
    function fValidaBaseInteira(): Boolean;
    function fJaExisteEssaBaseNaFormulacao(strCodBas: String; dbeForm: TObject): Boolean;

  public
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  frmCadAleNovasFormulas: TfrmCadAleNovasFormulas;

implementation

uses untFuncoesSimples, untIConfTinta,
    untAlessiImobiliariaNovasFormulasDinamica, untFuncTinta, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmCadAleNovasFormulas }

procedure TfrmCadAleNovasFormulas.btnExcluirClick(Sender: TObject);
var
  strCodNfm: String;
  nfm: TAlessiImobiliariaNovasFormulasDinamica;
begin
  nfm := nil;
  Try
    Try
      strCodNfm := dbeCodigo.Text;
      fStartTransaction;
      inherited;

      If blnExcluiu Then
      Begin
        nfm := TAlessiImobiliariaNovasFormulasDinamica.Create;
        nfm.fRemoverFormula(strCodNfm);
        fCommit;
      End
      Else
        fRollBack;
    Except
      on E: Exception do
      begin
        fRollBack;
        raise;
      end;
    End;
  Finally
    if Assigned(nfm) then FreeAndNil(nfm);
  End;

end;

procedure TfrmCadAleNovasFormulas.btnGravarClick(Sender: TObject);
var
  blnInsert: Boolean;
  strNfm: String;
  conf: IConfTinta;
  nfm: TAlessiImobiliariaNovasFormulasDinamica;
begin
  nfm := nil;
  Try
    Try
      conf     := fGetConfTinta('ALE');
      qryTabela     := qryCadNfm;
      blnInsert := (qryTabela.State = dsInsert);
      If (blnInsert) Then
      Begin
        strNfm := conf.fGet('PROCOD');
        qryTabela.FieldByName('NFM_CODNFM').AsString := Format('ESP %s %s', [VS_strCodEmp, fStrZero(StrToIntDef(strNfm, 1), 7)]);
      End;
      fStartTransaction;
      inherited;
      If (blnGravou) Then
      Begin
        Screen.Cursor := crHourGlass;
        nfm := TAlessiImobiliariaNovasFormulasDinamica.Create;
        nfm.fRemoverFormula(qryTabela.FieldByName('NFM_CODNFM').AsString);
        If nfm.fGravaCadNfm(qryCadNfm) Then
        Begin
          If (blnInsert) Then
          Begin
            conf.pSet('PROCOD', fStrZero(StrToInt(strNfm) + 1, 7));
          End;

          fCommit;
        End
        Else
          fRollBack;

        Screen.Cursor := crDefault;
        blnGravou := False;
      End;
    Except
      on E: Exception do
      begin
        fRollBack;
        fMensagem('ATENÇÃO', Format('Não foi possivel realizar a gravação da nova formula! [%s: %s]',
          [E.ClassName, E.Message]), ['&OK']);
      end;
    End;
  Finally
    if Assigned(nfm) then FreeAndNil(nfm);    
  End;
end;

procedure TfrmCadAleNovasFormulas.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  qryTabela.FieldByName('NFM_DTACAD').AsDateTime := Date;
  pSetFocus(dbeNomCor);
end;

procedure TfrmCadAleNovasFormulas.btnPesquisaClick(Sender: TObject);
  var
    arrSel: TConsultasArray;
    Key: Char;
begin
  key := '/';
  If fPesqFormulaTinta(Self, conAle, nil, qryTabela, Key, arrSel) Then
    pSetFocus(btnAlterar);

end;

constructor TfrmCadAleNovasFormulas.Create(AOwner: TComponent);
begin
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;
  inherited Create(AOwner);
  qryCadNfm := fCriarQuery('SELECT * FROM ALE_CADNFM', Self);
  dtsCadNfm := fCriaDataSource(qryCadNfm);

  pCriaDataSets;
  pLigaDataSets;

  qryTabela     := qryCadNfm;
  strNomeTabela := 'ALE_CADNFM';
  strNomeCampo  := 'NFM_CODNFM';

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

procedure TfrmCadAleNovasFormulas.dbeForm04KeyPress(Sender: TObject; var Key: Char);
var
  arrSel: TConsultasArray;
begin
  If fPesqColorantes(Self, conAle, TDBEdit(Sender), Nil, Nil, Key, arrSel) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadAleNovasFormulas.dbeProdutKeyPress(Sender: TObject; var Key: Char);
  var
    qryGen : TUniQuery;
    arrSel: TconsultasArray;
begin
  qryGen :=  fCriaQuery(Self);
  Try
    If fPesqBaseTinta(Self, conAle, Nil, Nil, qryGen, Key, arrSel) Then
    Begin
      dbeBase.Field.AsString                       := qryGen.FieldByName('BAS_BASE__').AsString;
      dbeProdut.Field.AsString                     := qryGen.FieldByName('BAS_PRODUT').AsString;
      dbeCodUni.Field.AsString                     := qryGen.FieldByName('BAS_CODUNI').AsString;
      qryCadNfm.FieldByName('NFM_EMBALA').AsString := qryGen.FieldByName('BAS_EMBALA').AsString;

      SelectNext(ActiveControl, True, True);
    End;
  Finally
    FreeAndNil(qryGen);
  End
end;

destructor TfrmCadAleNovasFormulas.Destroy;
begin
  if Assigned(stlCampos) then FreeAndNil(stlCampos);
  if Assigned(stlCamInd) then FreeAndNil(stlCamInd);
  if Assigned(stlDesInd) then FreeAndNil(stlDesInd);
  if Assigned(dtsCadNfm) then FreeAndNil(dtsCadNfm);
  if Assigned(qryCadNfm) then FreeAndNil(qryCadNfm);
  inherited Destroy;
end;

function TfrmCadAleNovasFormulas.fJaExisteEssaBaseNaFormulacao(strCodBas: String; dbeForm: TObject): Boolean;
var
  intCont: Integer;
begin
  Result := False;

  For intCont := 1 To 20 Do
  Begin
    If (RightStr(TDBEditFocus(dbeForm).Name, 2) <> fStrZero(intCont,2)) And
       (Not fEmptyStr(TDBEditFocus(FindComponent('dbeForm' + fStrZero(intCont,2))).Text)) Then
    Begin
      If TDBEditFocus(FindComponent('dbeForm' + fStrZero(intCont,2))).Text = strCodBas Then
        Result := True;
    End;
  End;
end;

function TfrmCadAleNovasFormulas.fValidaBase(strBas: String): Boolean;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriarQuery(' SELECT                     ' +
                            '   COUNT(*) AS QTD          ' +
                            ' FROM                       ' +
                            '   ALE_CADBAS               ' +
                            ' WHERE BAS_BASE__ = :BASE   ', Self);
      qryGen.ParamByName('BASE').AsString := strBas;
      qryGen.Open;
      Result := qryGen.FieldByName('QTD').AsInteger > 0;
    Except
      on E: Exception do
      begin
        Result := False;
        fMensagem('ATENÇÃO', Format('%s: %s', [E.ClassName, E.Message]), ['&Ok']);
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;                            
end;

function TfrmCadAleNovasFormulas.fValidaBaseInteira: Boolean;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Result := False;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT                       ' +
        '   COUNT(*) AS QTD            ' +
        ' FROM                         ' +
        '   ALE_CADBAS                 ' +
        ' WHERE BAS_PRODUT = :PRODUT   ' +
        '   AND BAS_BASE__ = :BASE__   ' +
        '   AND BAS_CODUNI = :CODUNI   ';

      qryGen.ParamByName('PRODUT').AsString := dbeProdut.Text;
      qryGen.ParamByName('BASE__').AsString := dbeBase.Text;
      qryGen.ParamByName('CODUNI').AsString := dbeCodUni.Text;
      qryGen.Open;

      Result := qryGen.FieldByName('QTD').AsInteger > 0;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);   
  End;
end;

function TfrmCadAleNovasFormulas.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
var
  dbeQtd: TDBEdit;
  dbeQtdf: TDBEdit;
  dbeForm: TDBEdit;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    if (Sender = dbeCodigo) then
    begin
      if fEmptyStr(dbeCodigo.Text) then
      begin
        fMensagem('ATENÇÃO', 'O campo código deve ser preenchido!', ['&OK']);
        Result := False;
      end;
    end
    else if (Sender = dbeNomCor) then
    begin
      if fEmptyStr(dbeNomCor.Text) then
      begin
        fMensagem('ATENÇÃO', 'O campo Nome Cor deve ser preenchido!', ['&OK']);
        Result := False;
      end;
    end
    else if (Sender = dbeProdut) then
    begin
      if fEmptyStr(dbeProdut.Text) then
      begin
        fMensagem('ATENÇÃO', 'O campo Produto deve ser preenchido!', ['&OK']);
        Result := False;
      end
      else if not fValidaProduto(dbeProdut.Text) then
      begin
        fMensagem('ATENÇÃO', 'O Produto preenchido não é válido!', ['&OK']);
        Result := False;
      end
      else if (not fEmptyStr(dbeProdut.Text)) and (not fEmptyStr(dbeBase.Text)) and (not fEmptyStr(dbeCodUni.Text))
        and not fValidaBaseInteira then
      begin
        fMensagem('ATENÇÃO', 'Não existe nenhuma base cadastrada com essa combinação de Produto + Base + Unidade', ['&Ok']);
        Result := False;
      end;

    end
    else if (Sender = dbeBase) then
    begin
      if fEmptyStr(dbeBase.Text) then
      begin
        fMensagem('ATENÇÃO', 'O campo Base deve ser preenchido!', ['&OK']);
        Result := False;
      end
      else if not fValidaBase(dbeBase.Text) then
      begin
        fMensagem('ATENÇÃO', 'A Base preenchida não é válida!', ['&Ok']);
        Result := False;
      end
      else if (not fEmptyStr(dbeProdut.Text)) and (not fEmptyStr(dbeBase.Text)) and (not fEmptyStr(dbeCodUni.Text))
        and not fValidaBaseInteira then
      begin
        fMensagem('ATENÇÃO', 'Não existe nenhuma base cadastrada com essa combinação de Produto + Base + Unidade', ['&Ok']);
        Result := False;
      end;
    end
    Else If fJaExisteEssaBaseNaFormulacao(TDBEditFocus(Sender).Text, Sender) Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa base já está cadastrada para essa fórmula!', ['&Ok']);
      Result := False;
    End
    else if (Sender = dbeCodUni) then
    begin
      if fEmptyStr(dbeCodUni.Text) then
      begin
        fMensagem('ATENÇÃO', 'O campo Unidade deve ser preenchido!', ['&OK']);
        Sender := dbeBase;
        Result := False;
      end
      else if (not fEmptyStr(dbeProdut.Text)) and (not fEmptyStr(dbeBase.Text)) and (not fEmptyStr(dbeCodUni.Text))
        and not fValidaBaseInteira then
      begin
        fMensagem('ATENÇÃO', 'Não existe nenhuma base cadastrada com essa combinação de Produto + Base + Unidade', ['&Ok']);
        Result := False;
      end;
    end
    else if (Sender = dbeForm01) then
    begin
      if fEmptyStr(dbeForm01.Text) then
      begin
        fMensagem('ATENÇÃO', 'O campo Colorante deve ser preenchido!', ['&OK']);
        Result := False;
      end
      else if not fValidaColorante(dbeForm01.Text) then
      begin
        fMensagem('ATENÇÃO', 'O colorante preenchido não é válido!', ['&OK']);
        Result := False;
      end;

    end
    else if (LeftStr(Sender.Name, 6) = 'dbeQtd') then
    begin
      dbeQtd  := TDBEdit(Self.FindComponent('dbeQtd' + RightStr(Sender.Name, 2)));
      dbeQtdf := TDBEdit(Self.FindComponent('dbeQtdf' + RightStr(Sender.Name, 2)));
      dbeForm := TDBEdit(Self.FindComponent('dbeForm' + RightStr(Sender.Name, 2)));
      if not fEmptyStr(dbeForm.Text) then
      begin
        if ((fStrToFloat(dbeQtd.Text) < 0) Or (fStrToFloat(dbeQtdf.Text) < 0)) then
        begin
          fMensagem('ATENÇÃO', 'A quantidade deve ser preenchida!', ['&Ok']);
          Result := False;
        end
        else if ((fStrToFloat(dbeQtd.Text) = 0) And (fStrToFloat(dbeQtdf.Text) = 0)) then
        begin
          fMensagem('ATENÇÃO', 'A quantidade deve ser preenchida!', ['&Ok']);
          Result := False;
        end
      end;
    end
    else if (LeftStr(Sender.Name, 7) = 'dbeForm') then
    begin
      dbeForm := TDBEdit(Self.FindComponent('dbeForm' + RightStr(Sender.Name, 2)));

      if not fEmptyStr(dbeForm.Text) then
      begin
        if not fValidaColorante(dbeForm.Text) then
        begin
          fMensagem('ATENÇÃO', 'O colorante preenchido não é válido!', ['&Ok']);
          Result := False;
        end;
      end
    end;
  End;

  If Not (Result) Then
    pSetFocus(Sender);
end;

function TfrmCadAleNovasFormulas.fValidaColorante(strCol: String): Boolean;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriarQuery(' SELECT ' +
                            '   COUNT(*) AS QTD          ' +
                            ' FROM                       ' +
                            '   ALE_CADCOL               ' +
                            ' WHERE COL_CODCOL = :CODCOL   ', Self);
      qryGen.ParamByName('CODCOL').AsString := strCol;
      qryGen.Open;
      Result := qryGen.FieldByName('QTD').AsInteger > 0;
    Except
      on E: Exception do
      begin
        Result := False;
        fMensagem('ATENÇÃO', Format('%s: %s', [E.ClassName, E.Message]), ['&OK']);
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;
end;

function TfrmCadAleNovasFormulas.fValidaProduto(strProd: String): Boolean;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriarQuery(' SELECT ' +
                            '   COUNT(*) AS QTD          ' +
                            ' FROM                       ' +
                            '   ALE_CADBAS               ' +
                            ' WHERE BAS_PRODUT = :PRODUT   ', Self);
      qryGen.ParamByName('PRODUT').AsString := strProd;
      qryGen.Open;
      Result := qryGen.FieldByName('QTD').AsInteger > 0;
    Except
      on E: Exception do
      begin
        Result := False;
        fMensagem('ATENÇÃO', Format('%s: %s', [E.ClassName, E.Message]), ['&OK']);
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;
end;

procedure TfrmCadAleNovasFormulas.pCriaDataSets;
var
  intCont: Integer;
begin
  qryCadNfm.FieldByName('NFM_CODNFM').DisplayLabel := 'Código';
  qryCadNfm.FieldbyName('NFM_PRODUT').DisplayLabel := 'Produto';
  qryCadNfm.FieldbyName('NFM_BASE__').DisplayLabel := 'Base';
  qryCadNfm.FieldbyName('NFM_CODUNI').DisplayLabel := 'Embalagem';
  qryCadNfm.FieldbyName('NFM_NOMCOR').DisplayLabel := 'Nome Cor';
  qryCadNfm.FieldbyName('NFM_NOMLON').DisplayLabel := 'Nome Longo';
  qryCadNfm.FieldbyName('NFM_DTACAD').DisplayLabel := 'Data Cadastro';

  qryCadNfm.FieldByName('AUTOINCREM').Visible := False;

  For intCont := 1 To 20 Do
  Begin
    TFloatField(qryCadNfm.FieldByName('NFM_QTOZ' + fStrZero(intCont, 2))).DisplayFormat := '0';
    TFloatField(qryCadNfm.FieldByName('NFM_QSHO' + fStrZero(intCont, 2))).DisplayFormat := '0.00';
  End;

end;

procedure TfrmCadAleNovasFormulas.pInicializaIndices;
begin
  inherited;
  stlCampos.Add('NFM_CODNFM');
  stlCampos.Add('NFM_PRODUT');
  stlCampos.Add('NFM_BASE__');
  stlCampos.Add('NFM_CODUNI');
  stlCampos.Add('NFM_NOMCOR');
  stlCampos.Add('NFM_NOMLON');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('NFM_CODNFM');
  stlCamInd.Add('NFM_PRODUT');
  stlCamInd.Add('NFM_BASE__');
  stlCamInd.Add('NFM_CODUNI');
  stlCamInd.Add('NFM_NOMCOR');
  stlCamInd.Add('NFM_NOMLON');
  stlCamInd.Add('AUTOINCREM');

  stlDesInd.Add('Código');
  stlDesInd.Add('Produto');
  stlDesInd.Add('Base');
  stlDesInd.Add('Embalagem');
  stlDesInd.Add('Nome Cor');
  stlDesInd.Add('Nome Longo');
end;

procedure TfrmCadAleNovasFormulas.pLigaDataSets;
var
  intCont: Integer;
begin
  For intCont := 0 To ComponentCount - 1 Do
  Begin
    If (Components[intCont] is TDBEdit) Then
    Begin
      (Components[intCont] as TDBEdit).DataSource := dtsCadNfm;
    End;
  End;

  dbeCodigo.DataField    := 'NFM_CODNFM';
  dbeNomCor.DataField    := 'NFM_NOMCOR';
  dbeNomLong.DataField   := 'NFM_NOMLON';
  dbeProdut.DataField    := 'NFM_PRODUT';
  dbeBase.DataField      := 'NFM_BASE__';
  dbeCodUni.DataField    := 'NFM_CODUNI';
  dbeDtaCad.DataField    := 'NFM_DTACAD';

  For intCont := 1 To 20 Do
  Begin
    TDBEdit(FindComponent('dbeForm' + fStrZero(intCont, 2))).DataField := 'NFM_CODC' + fStrZero(intCont, 2);
    TDBEdit(FindComponent('dbeQtd' + fStrZero(intCont, 2))).DataField  := 'NFM_QTOZ' + fStrZero(intCont, 2);
    TDBEdit(FindComponent('dbeQtdf' + fStrZero(intCont, 2))).DataField := 'NFM_QSHO' + fStrZero(intCont, 2);
  End;
end;

initialization
  RegisterClass(TfrmCadAleNovasFormulas);
finalization
  UnRegisterClass(TfrmCadAleNovasFormulas);

end.

