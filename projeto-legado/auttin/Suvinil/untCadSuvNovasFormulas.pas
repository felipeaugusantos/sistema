unit untCadSuvNovasFormulas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  EditFocus, Mask, DBCtrls, DBEditFocus, StrUtils, DB, AppEvnts, Uni,
  UniClientDataSet, UniDataSetProvider,   Grids, DBGridCitel, DBGrids,
  BitBtnLockedIncrem, MemDS, DBAccess, Datasnap.Provider;

type
  TfrmCadSuvNovasFormulas = class(TfrmPaiCad)
    pnlCentral: TPanel;
    pnlCabecalho: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    dbeCodNfm: TDBEditFocus;
    dbeDescri: TDBEditFocus;
    gpbColorantes: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
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
    dbeForm01: TDBEditFocus;
    dbeQtdC01: TDBEditFocus;
    dbeForm02: TDBEditFocus;
    dbeQtdC02: TDBEditFocus;
    dbeForm03: TDBEditFocus;
    dbeQtdC03: TDBEditFocus;
    dbeForm04: TDBEditFocus;
    dbeQtdC04: TDBEditFocus;
    dbeForm05: TDBEditFocus;
    dbeQtdC05: TDBEditFocus;
    dbeForm06: TDBEditFocus;
    dbeQtdC06: TDBEditFocus;
    dbeForm07: TDBEditFocus;
    dbeQtdC07: TDBEditFocus;
    dbeForm08: TDBEditFocus;
    dbeQtdC08: TDBEditFocus;
    dbeForm09: TDBEditFocus;
    dbeQtdC09: TDBEditFocus;
    dbeForm10: TDBEditFocus;
    dbeQtdC10: TDBEditFocus;
    dbeCodPro: TDBEditFocus;
    Label2: TLabel;
    dbeBase: TDBEditFocus;
    Label6: TLabel;
    dbeUnidad: TDBEditFocus;
    Label5: TLabel;
    chkEmbDif: TDBCheckBox;
    gpbEmbDif: TGroupBox;
    dbgEmbDif: TDBGridCitel;
    qryEmbDif: TUniQuery;
    dspEmbDif: TUniDataSetProvider;
    cdsEmbDif: TUniClientDataSet;
    dtsEmbDif: TDataSource;
    cdsEmbDifSUV_CODFML: TStringField;
    cdsEmbDifSUV_CODBAS: TStringField;
    cdsEmbDifSUV_CODUNI: TStringField;
    cdsEmbDifUNI_DESUNI: TStringField;
    cdsEmbDifNFM_VOLUME: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure dbeCodProKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodProExit(Sender: TObject);
    procedure dbeForm01KeyPress(Sender: TObject; var Key: Char);
    procedure cdsEmbDifBeforePost(DataSet: TDataSet);
    procedure cdsEmbDifBeforeInsert(DataSet: TDataSet);
    procedure chkEmbDifClick(Sender: TObject);
    procedure cdsEmbDifBeforeEdit(DataSet: TDataSet);
    procedure btnPesquisaClick(Sender: TObject);
    procedure dbgEmbDifEnter(Sender: TObject);
  private
    { Private declarations }
    intTamanhoInicial: Integer;

    strCodigoAnt: String;
    strBaseAnt: String;

    qrySuv_CadNfm: TUniQuery;
    dtsSuv_CadNfm: TDataSource;

    procedure pCarregaEmbalagens;
    procedure pGravarEmbDif;
    procedure pCriaTempEmb(const blnExiste: Boolean);    
    
    procedure pCriarDataSets;
    procedure pLigarDataSets;
  protected
    function fValidaColorante(strCodCol: String): Boolean;
    function fBaseCadastrada(strCodFml: String; strBase: String = ''; strUnidad: String = ''): Boolean;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  public
    { Public declarations }
  end;

var
  frmCadSuvNovasFormulas: TfrmCadSuvNovasFormulas;

implementation

uses
  untModuloTinta, untPai,
  untConstantes, untSuvinilImobiliaria, untFuncoesSimples, untIConfTinta,
  untFuncTinta;

{$R *.dfm}

{ TfrmCadSuvNovasForumulas }

function TfrmCadSuvNovasFormulas.fBaseCadastrada(strCodFml: String; strBase: String = ''; strUnidad: String = ''): Boolean;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  SUV_DESCRI ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  SUV_CADBAS ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  SUV_CODFML = :CODFML ';
  If (Not fEmptyStr(strBase)) Then
    strSQL := strSQL + '  AND SUV_CODBAS = :BASE ';

  If (Not fEmptyStr(strUnidad)) Then
    strSQL := strSQL + '  AND SUV_CODUNI = :UNIDAD ';

  With frmModuloTinta.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODFML').AsString  := strCodFml;

    If (Not fEmptyStr(strBase)) Then
      ParamByName('BASE').AsString := strBase;

    If (Not fEmptyStr(strUnidad)) Then
      ParamByName('UNIDAD').AsString := strUnidad;

    Open;
    Result := (Not IsEmpty);
    If (fEmptyStr(dbeDescri.Field.AsString)) And
       (qryTabela.State <> dsBrowse)         And
       (Not fEmptyStr(strBase))              Then
    Begin
      dbeDescri.Field.AsString := FieldByName('SUV_DESCRI').AsString;
    End;
    Close;
  End;
end;

function TfrmCadSuvNovasFormulas.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strNumCol: String;
begin

  Result := True;

  If (Sender = dbeCodNfm) Then
  Begin
  End

  Else If (Sender = dbeCodPro) Then
  Begin
    If (fEmptyStr(dbeCodPro.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A base deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else If (Not fBaseCadastrada(dbeCodPro.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa base nao está cadastrada!', ['&Ok']);
      Result := False;
    End
    Else If (dbeCodPro.Text <> strCodigoAnt) Then
    Begin
      strCodigoAnt := dbeCodPro.Text;
      If (chkEmbDif.Checked) Then
        pCarregaEmbalagens;
    End;
  End

  Else If (Sender = dbeBase) Then
  Begin
    If (fEmptyStr(dbeBase.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A base deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else If (Not fBaseCadastrada(dbeCodPro.Text, dbeBase.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa base nao está cadastrada!', ['&Ok']);
      Result := False;
    End
    Else If (dbeBase.Text <> strBaseAnt) Then
    Begin
      strBaseAnt := dbeBase.Text;
      If (chkEmbDif.Checked) Then
        pCarregaEmbalagens;
    End;
  End

  {*****************************************}
  {* VALIDA A UNIDADE                      *}
  {**************************************MV*}
  Else If (Sender = dbeUnidad) Then
  Begin

    If (fEmptyStr(dbeUnidad.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A unidade deve ser preenchida!', ['&O k']);
      Result := False;
    End
    Else If (Pos(dbeUnidad.Text, UNIDADES_BASE) <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa não é uma unidade válida (' + AnsiReplaceStr(UNIDADES_BASE, '_', ' ') + ')', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      If fEmptyStr(fRetNomUnidade(dbeUnidad.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa unidade não está cadastrada!', ['&O k']);
        Result := False;
      End;
      //Else If (Not fBaseCadastrada(dbeCodPro.Text, dbeBase.Text, dbeUnidad.Text)) Then
      //Begin
      //  fMensagem('ATENÇÃO!', 'Essa base nao está cadastrada!', ['&Ok']);
      //  Result := False;
      //End;
    End;

  End

  Else If (Sender = dbeDescri) Then
  Begin
    If (fEmptyStr(dbeDescri.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A descrição deve ser preenchida!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = dbeForm01) Then
  Begin
    If (fEmptyStr(dbeForm01.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'É necessário digitar pelo menos 1 colorante!', ['&Ok']);
      Result := False;
    End
    Else If (Not fValidaColorante(dbeForm01.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Colorante não encontrado!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = dbeForm02) Or
          (Sender = dbeForm03) Or
          (Sender = dbeForm04) Or
          (Sender = dbeForm05) Or
          (Sender = dbeForm06) Or
          (Sender = dbeForm07) Or
          (Sender = dbeForm08) Or
          (Sender = dbeForm09) Or
          (Sender = dbeForm10) Then
  Begin
    If (fEmptyStr((TEdit(Sender).Text))) Then
    Begin
      pSetFocus(dbeQtdC10)
    End
    Else If (Not fValidaColorante(TEdit(Sender).Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Colorante não encontrado!', ['&Ok']);    
      Result := False;
    End;
  End

  Else If (Sender = dbeQtdC01) Or
          (Sender = dbeQtdC02) Or
          (Sender = dbeQtdC02) Or
          (Sender = dbeQtdC03) Or
          (Sender = dbeQtdC04) Or
          (Sender = dbeQtdC05) Or
          (Sender = dbeQtdC06) Or
          (Sender = dbeQtdC07) Or
          (Sender = dbeQtdC08) Or
          (Sender = dbeQtdC09) Or
          (Sender = dbeQtdC10) Then
  Begin
    strNumCol := RightStr(Sender.Name, 2);
    If (Not fEmptyStr(TEdit(fComponentByName(gpbColorantes, 'dbeForm' + strNumCol)).Text)) Then
    Begin
      If (fEmptyStr(TEdit(Sender).Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'É necessário digitar a quantidade do colorante!', ['&Ok']);
        Result := False;
      End;
      If (fStrToFloat(TEdit(Sender).Text)) <= 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'A quantidade do colorante deve ser maior que Zero!', ['&Ok']);
        Result := False;
      End;
    End;
  End
end;

function TfrmCadSuvNovasFormulas.fValidaColorante(
  strCodCol: String): Boolean;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  COUNT(*) AS QTD ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  SUV_CADCOL ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  COL_CODCOL = :CODCOL ';

  With frmModuloTinta.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCOL').AsString := strCodCol;
    Open;
    Result := (FieldByName('QTD').AsInteger > 0);
    Close;
  End;
end;

procedure TfrmCadSuvNovasFormulas.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('NFM_CODNFM');
  stlCampos.Add('NFM_CODPRO');
  stlCampos.Add('NFM_BASE__');
  stlCampos.Add('NFM_UNIDAD');
  stlCampos.Add('NFM_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('NFM_CODNFM');
  stlCamInd.Add('NFM_DESCRI');
  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');
end;

procedure TfrmCadSuvNovasFormulas.FormCreate(Sender: TObject);
begin
  inherited;
  pCriarDataSets;
  pLigarDataSets;
  strNomeTabela := 'SUV_CADNFM';
  strNomeCampo  := 'NFM_CODNFM';
  qryTabela     := qrySuv_CadNfm;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodNfm;

  intTamanhoInicial := Self.Height;

  strCodigoAnt := '';
  strBaseAnt   := '';
end;

procedure TfrmCadSuvNovasFormulas.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  
  qrySuv_CadNfm.FieldByName('NFM_UNIDAD').AsString := 'LT';
  qrySuv_CadNfm.FieldByName('NFM_EMBDIF').AsString := 'N';

  strCodigoAnt := '';
  strBaseAnt   := '';

  dbeCodNfm.Enabled := False;
  pSetFocus(dbeCodPro);
end;

procedure TfrmCadSuvNovasFormulas.btnAlterarClick(Sender: TObject);
begin
  inherited;
  dbeCodNfm.Enabled := False;
  dbeCodPro.Enabled := False;
  dbeBase.Enabled   := False;
  {If (dbeUnidad.Enabled) Then
    pSetFocus(dbeUnidad);}
  If (dbeDescri.Enabled) Then
    pSetFocus(dbeDescri);
end;

procedure TfrmCadSuvNovasFormulas.btnGravarClick(Sender: TObject);
  Var
    blnInsert: Boolean;
    strNfmBri: String;
    conf: IConfTinta;
begin
  conf := fGetConfTinta('SUV');
  blnInsert := (qryTabela.State = dsInsert);
  If (blnInsert) Then
  Begin
    strNfmBri := conf.fGet('NFMSUV');
    qryTabela.FieldByName('NFM_CODNFM').AsString := 'ESP ' + VS_strCodEmp + fStrZero(strNfmBri, 5);
  End;
  inherited;

  If (blnGravou) Then
  Begin

    pGravarEmbDif;

    Screen.Cursor := crHourGlass;
    If (fGeraNovasFormulas(qryTabela)) Then
    Begin
      If (blnInsert) Then
      Begin
        conf.pSet('NFMSUV', fStrZero(StrToInt(strNfmBri) + 1, 5));
      End;
    End;
    Screen.Cursor := crDefault;
    blnGravou := False;
  End;
end;

procedure TfrmCadSuvNovasFormulas.btnExcluirClick(Sender: TObject);
  Var
    strCodNfm: String;
    strBase: String;
    strCodPro: String;
begin

  strCodNfm := dbeCodNfm.Text;
  strBase   := dbeBase.Text;
  strCodPro := dbeCodPro.Text;
  inherited;
  If (blnExcluiu) Then
  Begin

    strCodigoAnt := qryTabela.FieldByName('NFM_CODPRO').AsString;
    strBaseAnt   := qryTabela.FieldByName('NFM_BASE__').AsString;

    pDeletaNovaFormula(strCodNfm,
                       strBase,
                       strCodPro);
    chkEmbDifClick(chkEmbDif);
    blnExcluiu := False;
  End;
end;

procedure TfrmCadSuvNovasFormulas.btnCancelaClick(Sender: TObject);
begin
  inherited;
//  fBaseCadastrada(dbeCodBas.Text);
  strCodigoAnt := qryTabela.FieldByName('NFM_CODPRO').AsString;
  strBaseAnt   := qryTabela.FieldByName('NFM_BASE__').AsString;
  chkEmbDifClick(chkEmbDif);
end;

procedure TfrmCadSuvNovasFormulas.dbeCodProKeyPress(Sender: TObject;
  var Key: Char);
  Var
    stlCamIndBas: TStringList;
    stlDesIndBas: TStringList;
    qryAux: TUniQuery;
    strSQL: String;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    Key := #0;

    stlCamIndBas := TStringList.Create;
    stlDesIndBas := TStringList.Create;
    qryAux       := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  SUV_CODFML "Código", ';
    strSQL := strSQL + '  SUV_CODBAS "Base", ';
    strSQL := strSQL + '  SUV_CODUNI "Unidade", ';
    strSQL := strSQL + '  SUV_CODEMP "Emp.", ';
    strSQL := strSQL + '  SUV_CODITE "Item", ';
    strSQL := strSQL + '  ITE_DESITE "Desc. Item", ';
    strSQL := strSQL + '  SUV_DESCRI "Descrição", ';
    strSQL := strSQL + '  SUV_CADBAS.AUTOINCREM ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  SUV_CADBAS ';
    strSQL := strSQL + 'LEFT JOIN CADITE ON ITE_CODITE = SUV_CODITE ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  TRUE ';


    stlCamIndBas.Add('SUV_DESCRI');
    stlCamIndBas.Add('SUV_CODFML');
    stlCamIndBas.Add('SUV_CODBAS');
    stlCamIndBas.Add('SUV_CODITE');
    stlCamIndBas.Add('ITE_DESITE');

    stlDesIndBas.Add('Descrição');
    stlDesIndBas.Add('Código');
    stlDesIndBas.Add('Base');
    stlDesIndBas.Add('Item');
    stlDesIndBas.Add('Desc. Item');

    utcRegistros.Limpar(Self.Name + 'SUV_CADBAS');

    If pConsultaComp(Self, qryAux, 'SUV_CADBAS', strSQL, stlCamIndBas, stlDesIndBas) Then
    Begin
      TDBEditFocus(Sender).Text := qryAux.FieldByName('SUV_CODFML').AsString;
      If (fValidaCampos(TDBEditFocus(Sender), True)) Then
      Begin
        SelectNext(ActiveControl, True, True);
      End;
    End;

    FreeAndNil(qryAux);
    FreeAndNil(stlCamIndBas);
    FreeAndNil(stlDesIndBas);
  End;

end;

procedure TfrmCadSuvNovasFormulas.dbeCodProExit(Sender: TObject);
begin
  inherited;
  fValidaCampos(dbeCodPro, True);
end;

procedure TfrmCadSuvNovasFormulas.dbeForm01KeyPress(Sender: TObject;
  var Key: Char);
  Var
    strSQL: String;
    stlCamInd: TStringList;
    stlDesInd: TStringList;
    qryConsulta: TUniQuery;
begin

  If (fEntraCons(Key)) Then
  Begin

    Key := #0;

    qryConsulta := fCriaQuery;
    stlCamInd := TStringList.Create;
    stlDesInd := TStringList.Create;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  COL_CODCOL "Código", ';
    strSQL := strSQL + '  COL_CODITE "Item", ';
    strSQL := strSQL + '  ITE_DESITE "Desc. Item", ';
    strSQL := strSQL + '  SUV_CADCOL.AUTOINCREM ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  SUV_CADCOL ';
    strSQL := strSQL + 'LEFT JOIN CADITE ON ITE_CODITE = COL_CODITE ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  TRUE ';

    stlCamInd.Add('COL_CODCOL');
    stlCamInd.Add('COL_CODITE');
    stlCamInd.Add('ITE_DESITE');
    stlDesInd.Add('Código');
    stlDesInd.Add('Item');
    stlDesInd.Add('Desc. Item');

    If (pConsultaComp(Self, qryConsulta, 'SUV_CADCOL', strSQL, stlCamInd, stlDesInd)) Then
    Begin
      TEdit(Sender).Text := qryConsulta.FieldByName('COL_CODCOL').AsString;
      If fValidaCampos(TEdit(Sender), True) Then
        SelectNext(ActiveControl, True, True);
    End;

    FreeAndNil(stlCamInd);
    FreeAndNil(stlDesInd);
    FreeAndNil(qryConsulta);

  End;

end;

procedure TfrmCadSuvNovasFormulas.pCarregaEmbalagens;
begin
  Try
    qryEmbDif.Close;
    cdsEmbDif.Close;

    pCriaTempEmb(not fEmptyStr(qryTabela.FieldByName('NFM_CODNFM').AsString));

    qryEmbDif.SQL.Clear;
    qryEmbDif.SQL.Add('SELECT * FROM TMP_SUV_NFMEMB');
    cdsEmbDif.Open;

    TFloatField(cdsEmbDif.FieldByName('NFM_VOLUME')).DisplayFormat := '#,####0.0000';
  Except
    on E: Exception do
    begin
      fMensagem('ATENÇÃO', E.Message, ['OK']);
    end;
  End;

end;

procedure TfrmCadSuvNovasFormulas.cdsEmbDifBeforePost(DataSet: TDataSet);
begin
  inherited;
  If (DataSet.FieldByName('NFM_VOLUME').AsFloat < 0.0) Then
  Begin
    fMensagem('ATENÇÃO!', 'O volume deve ser maior ou igual a Zero.', ['&Ok']);
    DataSet.FieldByName('NFM_VOLUME').Value := DataSet.FieldByName('NFM_VOLUME').OldValue;
  End;
end;

procedure TfrmCadSuvNovasFormulas.cdsEmbDifBeforeInsert(DataSet: TDataSet);
begin
  inherited;
  Abort;
end;

procedure TfrmCadSuvNovasFormulas.chkEmbDifClick(Sender: TObject);
begin
  inherited;
  If chkEmbDif.Checked Then
  Begin
    Self.Height := intTamanhoInicial;
    gpbEmbDif.Visible := True;
    gpbEmbDif.Enabled := True;
    dbgEmbDif.Enabled := True;

    gpbEmbDif.Top := 400;

    pCarregaEmbalagens;
  End
  Else
  Begin
    Self.Height := intTamanhoInicial - gpbEmbDif.Height;
    gpbEmbDif.Visible := False;
    gpbEmbDif.Enabled := False;
    dbgEmbDif.Enabled := False;
  End;
end;

procedure TfrmCadSuvNovasFormulas.cdsEmbDifBeforeEdit(DataSet: TDataSet);
begin
  inherited;
  If (Not (qryTabela.State In [dsInsert, dsEdit])) Then
    Abort;
end;

procedure TfrmCadSuvNovasFormulas.pGravarEmbDif;
  Var
    qryAux: TUniQuery;
begin

  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add('DELETE FROM SUV_NFMEMB WHERE NFM_CODNFM = :CODNFM ');
  qryAux.ParamByName('CODNFM').AsString := qryTabela.FieldByName('NFM_CODNFM').AsString;
  qryAux.ExecSQL;

  qryAux.SQL.Clear;
  qryAux.SQL.Add('INSERT INTO SUV_NFMEMB (');
  qryAux.SQL.Add('  NFM_CODNFM, ');
  qryAux.SQL.Add('  NFM_CODFML, ');
  qryAux.SQL.Add('  NFM_CODBAS, ');
  qryAux.SQL.Add('  NFM_UNIDAD, ');
  qryAux.SQL.Add('  NFM_VOLUME, ');
  qryAux.SQL.Add('  AUTOINCREM ');
  qryAux.SQL.Add(') VALUES ( ');
  qryAux.SQL.Add('  :CODNFM, ');
  qryAux.SQL.Add('  :CODFML, ');
  qryAux.SQL.Add('  :CODBAS, ');
  qryAux.SQL.Add('  :UNIDAD, ');
  qryAux.SQL.Add('  :VOLUME, ');
  qryAux.SQL.Add('  :AUTINC) ');

  If (chkEmbDif.Checked) Then
  Begin
    cdsEmbDif.First;
    While (Not cdsEmbDif.Eof) Do
    Begin
      qryAux.ParamByName('CODNFM').AsString := qryTabela.FieldByName('NFM_CODNFM').AsString;
      qryAux.ParamByName('CODFML').AsString := qryTabela.FieldByName('NFM_CODPRO').AsString;
      qryAux.ParamByName('CODBAS').AsString := qryTabela.FieldByName('NFM_BASE__').AsString;
      qryAux.ParamByName('UNIDAD').AsString := cdsEmbDif.FieldByName('SUV_CODUNI').AsString;
      qryAux.ParamByName('VOLUME').AsFloat  := cdsEmbDif.FieldByName('NFM_VOLUME').AsFloat;
      qryAux.ParamByName('AUTINC').AsString := fRetAutoIncrem('SUV_NFMEMB', VS_strCodEmp);
      qryAux.ExecSQL;

      cdsEmbDif.Next;
    End;
  End
  Else
  Begin
    pCarregaEmbalagens;
  End;

  FreeAndNil(qryAux);

end;

procedure TfrmCadSuvNovasFormulas.btnPesquisaClick(Sender: TObject);
begin
  inherited;
  strCodigoAnt := qryTabela.FieldByName('NFM_CODPRO').AsString;
  strBaseAnt   := qryTabela.FieldByName('NFM_BASE__').AsString;
end;

procedure TfrmCadSuvNovasFormulas.dbgEmbDifEnter(Sender: TObject);
begin
  inherited;
  dbgEmbDif.SelectedIndex := 2;
end;

procedure TfrmCadSuvNovasFormulas.pCriarDataSets;
  Var
    intCont : Integer;
begin
  qrySuv_CadNfm := fCriarQuery('SELECT * FROM SUV_CADNFM', Self);
  For intCont := 1 To 10 Do
  Begin
    TFloatField(qrySuv_CadNfm.FieldByName('NFM_QTDC' + fStrZero(intCont, 2))).DisplayFormat := '0.00';
    TFloatField(qrySuv_CadNfm.FieldByName('NFM_QTDC' + fStrZero(intCont, 2))).EditFormat := '0.00';
  end;

  qrySuv_CadNfm.FieldByName('NFM_CODNFM').DisplayLabel := 'Cód. Nova Fórmula';
  qrySuv_CadNfm.FieldByName('NFM_CODPRO').DisplayLabel := 'Código do Produto';
  qrySuv_CadNfm.FieldByName('NFM_BASE__').DisplayLabel := 'Cód. Base';
  qrySuv_CadNfm.FieldByName('NFM_UNIDAD').DisplayLabel := 'Unidade';
  qrySuv_CadNfm.FieldByName('NFM_DESCRI').DisplayLabel := 'Descrição';

  qrySuv_CadNfm.FieldByName('AUTOINCREM').Visible := False;

  dtsSuv_CadNfm := fCriaDataSource(qrySuv_CadNfm);
end;

procedure TfrmCadSuvNovasFormulas.pLigarDataSets;
  Var
    intCont: Integer;
begin
  For intCont := 0 To ComponentCount - 1 Do
  Begin
  
    If (Components[intCont] is TDBEdit) Then
      TDBEdit(Components[intCont]).DataSource := dtsSuv_CadNfm
    Else If (Components[intCont] is TDBCheckBox) Then
      TDBCheckBox(Components[intCont]).DataSource := dtsSuv_CadNfm;

  End;
end;

procedure TfrmCadSuvNovasFormulas.pCriaTempEmb(const blnExiste: Boolean);
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      fDropTable('TMP_SUV_NFMEMB');
      qryGen := fCriaQuery();
      If (blnExiste) Then
      Begin
        qryGen.SQL.Clear;
        qryGen.SQL.Add('CREATE TEMPORARY TABLE TMP_SUV_NFMEMB AS ');
        qryGen.SQL.Add('SELECT ');
        qryGen.SQL.Add('  B.SUV_CODFML, ');
        qryGen.SQL.Add('  B.SUV_CODBAS, ');
        qryGen.SQL.Add('  B.SUV_CODUNI, ');
        qryGen.SQL.Add('  U.UNI_DESUNI, ');
        qryGen.SQL.Add('  IFNULL(E.NFM_VOLUME, 0.0000) AS NFM_VOLUME ');
        qryGen.SQL.Add('FROM ');
        qryGen.SQL.Add('  SUV_CADBAS B ');
        qryGen.SQL.Add('  JOIN CADUNI U ON U.UNI_CODUNI = SUV_CODUNI ');
        qryGen.SQL.Add('  LEFT JOIN SUV_CADNFM N ON B.SUV_CODFML = N.NFM_CODPRO AND ');
        qryGen.SQL.Add('                            B.SUV_CODBAS = N.NFM_BASE__ ');
        qryGen.SQL.Add('  LEFT JOIN SUV_NFMEMB E ON E.NFM_CODNFM = N.NFM_CODNFM AND ');
        qryGen.SQL.Add('	                           E.NFM_CODFML = N.NFM_CODPRO AND ');
        qryGen.SQL.Add('                            E.NFM_CODBAS = N.NFM_BASE__ AND ');
        qryGen.SQL.Add('                            E.NFM_UNIDAD = B.SUV_CODUNI ');
        qryGen.SQL.Add('WHERE ');
        qryGen.SQL.Add('  N.NFM_CODNFM = :CODNFM ');

        qryGen.ParamByName('CODNFM').AsString := qryTabela.FieldByName('NFM_CODNFM').AsString;
      End
      Else
      Begin

        If (fEmptyStr(dbeCodPro.Text)) Or (fEmptyStr(dbeBase.Text)) Then
        Begin
          chkEmbDif.Checked := False;
          raise Exception.Create('Para digitar embalagens diferenciadas, é necesário informar a base.');
        End;

        qryGen.SQL.Clear;
        qryGen.SQL.Add('CREATE TEMPORARY TABLE TMP_SUV_NFMEMB AS ');
        qryGen.SQL.Add('SELECT ');
        qryGen.SQL.Add('  B.SUV_CODFML, ');
        qryGen.SQL.Add('  B.SUV_CODBAS, ');
        qryGen.SQL.Add('  B.SUV_CODUNI, ');
        qryGen.SQL.Add('  U.UNI_DESUNI, ');
        qryGen.SQL.Add('  0.0000 AS NFM_VOLUME ');
        qryGen.SQL.Add('FROM ');
        qryGen.SQL.Add('  SUV_CADBAS B ');
        qryGen.SQL.Add('  JOIN CADUNI U ON U.UNI_CODUNI = SUV_CODUNI ');
        qryGen.SQL.Add('WHERE ');
        qryGen.SQL.Add('  B.SUV_CODFML = :CODFML AND ');
        qryGen.SQL.Add('  B.SUV_CODBAS = :CODBAS ');

        qryGen.ParamByName('CODFML').AsString := dbeCodPro.Text;
        qryGen.ParamByName('CODBAS').AsString := dbeBase.Text;
      End;
      
      qryGen.ExecSQL;

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


initialization
  RegisterClass(TfrmCadSuvNovasFormulas);
finalization
  UnRegisterClass(TfrmCadSuvNovasFormulas);

end.

