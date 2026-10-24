unit untCadSkyNovasFormulas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons, DB,
  ExtCtrls, Mask, DBCtrls, DBEditFocus, EditFocus, Grids, DBGridCitel, DBGrids, Uni,
  UniClientDataSet, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadSkyNovasFormulas = class(TfrmPaiCad)
    Panel1: TPanel;
    Label1: TLabel;
    dbeCodigo: TDBEditFocus;
    Label3: TLabel;
    dbeGrupo: TDBEditFocus;
    Label4: TLabel;
    dbeSubGrupo: TDBEditFocus;
    Label5: TLabel;
    dbeDescri: TDBEditFocus;
    Label6: TLabel;
    dbeAno: TDBEditFocus;
    Label7: TLabel;
    dbeCodMon: TDBEditFocus;
    Label8: TLabel;
    dbeCodPai: TDBEditFocus;
    Label9: TLabel;
    dbeVariante: TDBEditFocus;
    Label10: TLabel;
    dbeNacionalidade: TDBEditFocus;
    Label2: TLabel;
    dbeObserv: TDBEditFocus;
    Label11: TLabel;
    dbeAcrMob: TDBEditFocus;
    pnlCabecalho: TPanel;
    Label28: TLabel;
    dbeDtaCad: TDBEditFocus;
    Panel2: TPanel;
    Panel3: TPanel;
    btnAdicionarFormula: TBitBtnLocked;
    btnExcluirformula: TBitBtnLocked;
    dbgBases: TDBGridCitel;
    cmbTipoFormula: TComboBox;
    Label12: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnAdicionarFormulaClick(Sender: TObject);
    procedure dbgBasesKeyPress(Sender: TObject; var Key: Char);
    procedure btnExcluirformulaClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure dbeSubGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodMonKeyPress(Sender: TObject; var Key: Char);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure dbgBasesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    qryCadNfm: TUniQuery;
    dtsCadNfm: TDataSource;
    cdsCadNfm: TUniClientDataSet;
    dtsCdsCadNfm: TDataSource;
    blnBtnIns: Boolean;
    qryCadBas: TUniQuery;
    procedure pCriaDataSets;
    procedure pLigaDataSets;
    procedure pBeforePost(DataSet: TDataSet);
    procedure pAfterInsert(DataSet: TDataSet);
    procedure pAfterScroll(DataSet: TDataSet);
    procedure pCdsBeforePost(DataSet: TDataSet);
    function fVerificaGrupo(strGrupo: String): Boolean;
    function fVerificaSGrupo(strSGrupo: String): Boolean;
    function fVerificaMontadora(strCodMon: String): Boolean;
    procedure pHabilitarIncExcItem;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCadSkyNovasFormulas: TfrmCadSkyNovasFormulas;

implementation

uses untSkyMixAutomotivaDinamica, untFuncoesSimples,
      untIConfTinta, untFuncTinta,untPai, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadSkyNovasFormulas.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaDataSets;
  pLigaDataSets;

  strNomeTabela := 'SKY_CADNFM';
  strNomeCampo  := 'NFM_CODNFM';
  qryTabela     := qryCadNfm;
  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;

  pHabilitarIncExcItem;
end;

procedure TfrmCadSkyNovasFormulas.pBeforePost(DataSet: TDataSet);
begin
  cdsCadNfm.First;
  While Not cdsCadNfm.Eof Do
  Begin
    if cdsCadNfm.RecNo > 20 then
    begin
      fMensagem('ATENÇÃO', 'Só é permitido no máximo 20 bases por formulação!', ['OK']);
      Application.ProcessMessages;
      Abort;
    end;  
      
    qryCadNfm.FieldByName('NFM_FORM' + fStrZero(cdsCadNfm.RecNo, 2)).AsString := cdsCadNfm.FieldByName('NFM_FORM').AsString;
    qryCadNfm.FieldByName('NFM_QTDB' + fStrZero(cdsCadNfm.RecNo, 2)).AsFloat := cdsCadNfm.FieldByName('NFM_QTDB').AsFloat;
    cdsCadNfm.Next;
  End;
end;

procedure TfrmCadSkyNovasFormulas.pCriaDataSets;
begin
  qryCadNfm := fCriaZQuery('SELECT * FROM SKY_CADNFM');
  qryCadNfm.Open;
  qryCadNfm.BeforePost := pBeforePost;
  blnBtnIns := False;

  cdsCadNfm := TUniClientDataSet.Create(Self);
  cdsCadNfm.AfterInsert := pAfterInsert;

  cdsCadNfm.FieldDefs.Add('NFM_FORM', ftString, 7);
  cdsCadNfm.FieldDefs.Add('NFM_DESB', ftString, 40);
  cdsCadNfm.FieldDefs.Add('NFM_QTDB', ftFloat);
  cdsCadNfm.CreateDataSet;
  cdsCadNfm.BeforePost := pCdsBeforePost;
  TFloatField(cdsCadNfm.FieldByName('NFM_QTDB')).DisplayFormat := '0.000';

  qryCadNfm.AfterScroll := pAfterScroll;

  dtsCdsCadNfm := fCriaDataSource(cdsCadNfm);


  qryCadNfm.FieldByName('NFM_CODEMP').Visible := False;

  qryCadNfm.FieldByName('NFM_ANUANC').DisplayLabel := 'Variante';
  qryCadNfm.FieldByName('NFM_CODPRO').DisplayLabel := 'Código do Produto';
  qrycadNfm.FieldByName('NFM_DESCRI').DisplayLabel := 'Descrição';
  qrycadNfm.FieldByName('NFM_ANOFAB').DisplayLabel := 'Ano de Fabricação';
  qrycadNfm.FieldByName('NFM_CODUNI').DisplayLabel := 'Cód Universal';
  qrycadNfm.FieldByName('NFM_NACIMP').DisplayLabel := 'Nacional / Importado';
  qrycadNfm.FieldByName('NFM_CODMON').DisplayLabel := 'Código Montadora';
  qrycadNfm.FieldByName('NFM_CODSGR').DisplayLabel := 'Sub Grupo';
  qrycadNfm.FieldByName('NFM_CONDIL').DisplayLabel := 'Concentrado / Diluído';
  qrycadNfm.FieldByName('NFM_VERSAO').DisplayLabel := 'Versão';
  qryCadNfm.FieldByName('NFM_CODNFM').DisplayLabel := 'Código';
  qryCadNfm.FieldByName('NFM_CORPAI').DisplayLabel := 'Cor Pai';
  qryCadNfm.FieldByName('NFM_CODGRU').DisplayLabel := 'Cód. Grupo';
  qryCadNfm.FieldByName('NFM_ACRMOB').DisplayLabel := 'Acréscimo mão de obra';

  qryCadNfm.FieldByName('AUTOINCREM').Visible := False;

  TFloatField(qryCadNfm.FieldByName('NFM_ACRMOB')).DisplayFormat := '0.00';

  dtsCadNfm := fCriaDataSource(qryCadNfm);

  qryCadBas := fCriaZQuery('SELECT * FROM SKY_CADBAS', Self);
  qryCadBas.Open;

end;

procedure TfrmCadSkyNovasFormulas.pHabilitarIncExcItem;
begin
  btnAdicionarFormula.Enabled := qryTabela.State in [dsEdit, dsInsert];
  btnExcluirformula.Enabled := qryTabela.State in [dsEdit, dsInsert];
end;

procedure TfrmCadSkyNovasFormulas.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('NFM_CODNFM');
  stlCampos.Add('NFM_CODPRO');
  stlCampos.Add('NFM_DESCRI');
  stlCampos.Add('NFM_ANOFAB');
  stlCampos.Add('NFM_CODUNI');
  stlCampos.Add('NFM_ANUANC');
  stlCampos.Add('NFM_CORPAI');
  stlCampos.Add('NFM_NACIMP');
  stlCampos.Add('NFM_CODMON');
  stlCampos.Add('NFM_CODGRU');
  stlCampos.Add('NFM_CODSGR');
  stlCampos.Add('NFM_CONDIL');
  stlCampos.Add('NFM_VERSAO');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('NFM_CODNFM');
  stlCamInd.Add('NFM_CODPRO');
  stlCamInd.Add('NFM_DESCRI');
  stlCamInd.Add('NFM_ANOFAB');
  stlCamInd.Add('NFM_CODUNI');
  stlCamInd.Add('NFM_ANUANC');
  stlCamInd.Add('NFM_CORPAI');
  stlCamInd.Add('NFM_NACIMP');
  stlCamInd.Add('NFM_CODMON');
  stlCamInd.Add('NFM_CODGRU');
  stlCamInd.Add('NFM_CODSGR');
  stlCamInd.Add('NFM_CONDIL');
  stlCamInd.Add('NFM_VERSAO');
  stlCamInd.Add('AUTOINCREM');

  stlDesInd.Add('Código');
  stlDesInd.Add('Cód. Prod');
  stlDesInd.Add('Descrição');
  stlDesInd.Add('Ano Fabricação');
  stlDesInd.Add('Cód. Universal');
  stlDesInd.Add('Variante');
  stlDesInd.Add('Cor Pai');
  stlDesInd.Add('Nacional/Importado');
  stlDesInd.Add('Cód Montadora');
  stlDesInd.Add('Grupo');
  stlDesInd.Add('Sub Grupo');
  stlDesInd.Add('Concentrado / Diluído');
  stlDesInd.Add('Versão');

end;

procedure TfrmCadSkyNovasFormulas.pLigaDataSets;
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

  dbeCodigo.DataField := 'NFM_CODNFM';
  dbeDescri.DataField := 'NFM_DESCRI';
  dbeAno.DataField := 'NFM_ANOFAB';
  dbeCodMon.DataField := 'NFM_CODMON';
  dbeCodPai.DataField := 'NFM_CORPAI';
  dbeGrupo.DataField := 'NFM_CODGRU';
  dbeNacionalidade.DataField := 'NFM_NACIMP';
  dbeSubGrupo.DataField := 'NFM_CODSGR';
  dbeVariante.DataField := 'NFM_ANUANC';
  dbeObserv.DataField := 'NFM_OBS001';
  dbeAcrMob.DataField := 'NFM_ACRMOB';
  dbeDtaCad.DataField := 'NFM_DTACAD';

  dbgBases.DataSource := dtsCdsCadNfm;
end;

procedure TfrmCadSkyNovasFormulas.btnAdicionarFormulaClick(Sender: TObject);
  Var
    arrSel: TConsultasArray;
    qryGen : TUniQuery;
    key: char;
begin
  key := '/';
  If not (qryTabela.State in [dsEdit, dsInsert]) Then
    Exit;

  If cdsCadNfm.RecordCount > 0 Then
  Begin
    If cdsCadNfm.FieldByName('NFM_QTDB').IsNull Then
    Begin
      fMensagem('ATENÇÃO', 'A quantidade não foi digitada!', ['OK']);
      Exit;
    End;

    If cdsCadNfm.FieldByName('NFM_QTDB').AsFloat <= 0 Then
    Begin
      fMensagem('ATENÇÃO', 'A quantidade deve ser maior que zero', ['OK']);
      Exit;
    End;

  End;

  qryGen :=  fCriaQuery(Self);

  If fPesqBaseTinta(Self, conSky, nil, nil, qryGen, key, arrSel)
     and (not qryGen.IsEmpty) Then
  Begin
    blnBtnIns := True;

    If cdsCadNfm.Locate('NFM_FORM;NFM_DESB', VarArrayOf([qryGen.FieldByName('BAS_CODBAS').AsString, qryGen.FieldByName('BAS_DESCRI').AsString]), []) Then
      cdsCadNfm.Edit
    Else
      cdsCadNfm.Append;

    cdsCadNfm.FieldByName('NFM_FORM').AsString := qryGen.FieldByName('BAS_CODBAS').AsString;
    cdsCadNfm.FieldByName('NFM_DESB').AsString := qryGen.FieldByName('BAS_DESCRI').AsString;

    pSetFocus(dbgBases);
    dbgBases.SelectedIndex := 2;
    cdsCadNfm.Post;
    blnBtnIns := False;
  End;

  FreeAndNil(qryGen);
end;

procedure TfrmCadSkyNovasFormulas.pAfterInsert(DataSet: TDataSet);
begin
  If Not blnBtnIns Then
    DataSet.Cancel;
end;

procedure TfrmCadSkyNovasFormulas.dbgBasesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If not (qryTabela.State in [dsEdit, dsInsert]) Then
    Exit;

  If (Key = VK_DELETE) Then
    btnExcluirformula.Click;
end;

procedure TfrmCadSkyNovasFormulas.dbgBasesKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If not (qryTabela.State in [dsEdit, dsInsert]) Then
    Exit;
      
  If (Key = 'i') Or (Key = 'I') Or (Key = '+') Or (Key = '/') Then
    btnAdicionarFormula.Click;
  If (Key = 'e') Or (Key = 'E') Or (Key = '-') Then
    btnExcluirformula.Click;
end;

procedure TfrmCadSkyNovasFormulas.btnExcluirformulaClick(Sender: TObject);
begin
  If not (qryTabela.State in [dsEdit, dsInsert]) Then
    Exit;
    
  inherited;
  If Not cdsCadNfm.IsEmpty Then
    cdsCadNfm.Delete;
end;

procedure TfrmCadSkyNovasFormulas.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  qryTabela.FieldByName('NFM_DTACAD').AsDateTime := Date;

  cmbTipoFormula.ItemIndex := 0;

  pSetFocus(dbeGrupo);
  pHabilitarIncExcItem;
end;

procedure TfrmCadSkyNovasFormulas.btnPesquisaClick(Sender: TObject);
  var
    arrSel: TConsultasArray;
    Key: Char;
begin
  key := '/';
  If fPesqFormulaTinta(Self, conSky, Nil, qryTabela, key, arrSel) Then
  Begin
    if qryTabela.FieldByName('NFM_CONDIL').AsString =  'CONCENTRADO' Then
      cmbTipoFormula.ItemIndex := 0
    else
      cmbTipoFormula.ItemIndex := 1;

    pHabilitarIncExcItem;
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadSkyNovasFormulas.pAfterScroll(DataSet: TDataSet);
  Var
    intCont: Integer;
begin

  While Not cdsCadNfm.IsEmpty Do
  Begin
    cdsCadNfm.Delete;
  End;

  For intCont := 1 To 20 Do
  Begin
    If qryCadNfm.FieldByName('NFM_QTDB' + fStrZero(intCont, 2)).AsFloat = 0 Then
      Break;

    blnBtnIns := True;
    cdsCadNfm.Insert;
    cdsCadNfm.FieldByName('NFM_FORM').AsString := qryCadNfm.FieldByName('NFM_FORM' + fStrZero(intCont, 2)).AsString;
    cdsCadNfm.FieldByName('NFM_QTDB').AsFloat := qryCadNfm.FieldByName('NFM_QTDB' + fStrZero(intCont, 2)).AsFloat;

    qryCadBas.Locate('BAS_CODBAS', qryCadNfm.FieldByName('NFM_FORM' + fStrZero(intCont, 2)).AsString, []);
    cdsCadNfm.FieldByName('NFM_DESB').AsString := qryCadBas.FieldByName('BAS_DESCRI').AsString;

    cdsCadNfm.Post;
    blnBtnIns := False;
  End;

end;

procedure TfrmCadSkyNovasFormulas.btnGravarClick(Sender: TObject);
  Var
    blnInsert: Boolean;
    strNfmBri: String;
    conf: IConfTinta;
begin
  conf := fGetConfTinta('SKY');
  If (cdsCadNfm.FieldByName('NFM_QTDB').IsNull) Or (cdsCadNfm.FieldByName('NFM_QTDB').AsFloat <= 0) Then
    cdsCadNfm.Cancel
  Else If cdsCadNfm.State in [dsEdit, dsInsert] Then
    cdsCadNfm.Post;

  If (cdsCadNfm.FieldByName('NFM_QTDB').IsNull) Or (cdsCadNfm.RecordCount = 0) Then
  Begin
    fMensagem('ATENÇÃO', 'Entre com pelo menos uma base!', ['OK']);
    Exit;
  End;

  qryTabela     := qryCadNfm;

  qryTabela.FieldByName('NFM_CODPRO').AsString := qryTabela.FieldByName('NFM_CODNFM').AsString;
  qryTabela.FieldByName('NFM_CONDIL').AsString := cmbTipoFormula.Text;

  blnInsert := (qryTabela.State = dsInsert);
  If (blnInsert) Then
  Begin
    strNfmBri := conf.fGet('SKYNFM'); //fArqIniTinta(0, 'SkyMix Automotiva', 'SKYNFM', '0');
    qryTabela.FieldByName('NFM_CODNFM').AsString := 'ESP ' + fStrZero(strNfmBri, 5);
  End;
  fStartTransaction;
  inherited;

  Try
    If (blnGravou) Then
    Begin
      Screen.Cursor := crHourGlass;
      If fGravaNovaFormula(qryTabela) Then
      Begin
        If (blnInsert) Then
        Begin
          conf.pSet('SKYNFM', fStrZero(StrToInt(strNfmBri) + 1, 5)); //fArqIniTinta(1, 'SkyMix Automotiva', 'SKYNFM', fStrZero(StrToInt(strNfmBri) + 1, 5));
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

  pHabilitarIncExcItem;
end;

procedure TfrmCadSkyNovasFormulas.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pSetFocus(dbeGrupo);
  pHabilitarIncExcItem;
end;

procedure TfrmCadSkyNovasFormulas.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pHabilitarIncExcItem;
  pAfterScroll(qryCadNfm);
end;

procedure TfrmCadSkyNovasFormulas.btnExcluirClick(Sender: TObject);
  Var
    strCodNfm: String;
    qryGen : TUniQuery;
begin
  strCodNfm := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
  inherited;

  Try
    If blnExcluiu Then
    Begin
      qryGen := fCriaQuery(Self);
      qryGen.SQL.Text := 'DELETE FROM SKY_CADSKY WHERE SKY_CODNFM = :CODNFM';
      qryGen.ParamByName('CODNFM').AsString := strCodNfm;
      qryGen.ExecSQL;
      fCommit;

      cmbTipoFormula.ItemIndex := -1;

      FreeAndNil(qryGen);
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

  pHabilitarIncExcItem;
end;

procedure TfrmCadSkyNovasFormulas.dbeGrupoKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery;
  Try
    If fPesqSkyGrupoTinta(Self, nil, qryGen, Key, arrSel) Then
    Begin
      qryCadNfm.FieldByName('NFM_CODGRU').AsString := qryGen.FieldByName('GRU_CODGRU').AsString;
      SelectNext(ActiveControl, True, True);
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmCadSkyNovasFormulas.dbeSubGrupoKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
    qryGen : TUniQuery;
begin
  qryGen :=  fCriaQuery(Self);
  Try
    If fPesqSkySubGrupoTinta(Self, Nil, qryGen, Key, arrSel) Then
    Begin
      qryCadNfm.FieldByName('NFM_CODSGR').AsString := qryGen.FieldByName('SGR_CODSGR').AsString;
      SelectNext(ActiveControl, True, True);
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmCadSkyNovasFormulas.dbeCodMonKeyPress(Sender: TObject; var Key: Char);
  Var
    qryGen : TUniQuery;
    arrSel : TConsultasArray;
begin
  qryGen:= fCriaQuery;
  Try
    If fPesqMontadoraTinta(Self, conSky, nil, nil, qryGen, Key, arrSel) Then
    Begin
      qryCadNfm.FieldByName('NFM_CODMON').AsString := qryGen.FieldByName('MON_CODMON').AsString;
      SelectNext(ActiveControl, True, True);
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TfrmCadSkyNovasFormulas.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If Sender = dbeDescri Then
    Begin
      If fEmptyStr(dbeDescri.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'A descrição deve ser preenchida!', ['OK']);
        Result := False;
      End;
    End;

    If Sender = dbeGrupo Then
    Begin
      If Not fVerificaGrupo(dbeGrupo.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O grupo não está cadastrado', ['OK']);
        Result := False;
      End;
    End;

    If Sender = dbeSubGrupo Then
    Begin
      If Not fVerificaSGrupo(dbeSubGrupo.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O subgrupo não está cadastrado', ['OK']);
        Result := False;
      End;
    End;

    If Sender = dbeCodMon Then
    Begin
      If Not fVerificaMontadora(dbeCodMon.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'A Montadora não está cadastrada', ['OK']);
        Result := False;
      End;
    End;

    If Sender = dbeNacionalidade Then
    Begin
      If fEmptyStr(dbeNacionalidade.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'A nacionalidade deve ser preechida', ['OK']);
        Result := False;
      End
      Else If Not ((dbeNacionalidade.Text = 'N') Or (dbeNacionalidade.Text = 'I')) Then
      Begin
        fMensagem('ATENÇÃO', 'Preencha a nacionalidade com N (Nacional) ou I (Importado)', ['OK']);
        Result := False;
      End;
    End

    Else If (Sender = dbeAcrMob) Then
    Begin
      If fEmptyStr(dbeAcrMob.Text) Then
      Begin
        dbeAcrMob.Field.AsFloat := 0.00;
      End
      Else If Not fEmptyStr(dbeAcrMob.Text) Then
      Begin
        If (fStrToFloat(dbeAcrMob.Text) < 0) Then
        Begin
          Result := fMensagem('ATENÇÃO', 'O Acréscimo de Mão de Obra deve ser maior ou igual a zero', ['OK']) = -1;
        End;
      End;
    End;
  End;



  If Not Result Then
    pSetFocus(Sender);

end;

function TfrmCadSkyNovasFormulas.fVerificaGrupo(strGrupo: String): Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaZQuery('SELECT COUNT(*) AS "QUANT" FROM SKY_CADGRU WHERE GRU_CODGRU = :CODGRU',Self);
  qryGen.ParamByName('CODGRU').AsString := strGrupo;
  qryGen.Open;
  Result := qryGen.FieldByName('QUANT').AsInteger > 0;
  FreeAndNil(qryGen);
end;

function TfrmCadSkyNovasFormulas.fVerificaSGrupo(
  strSGrupo: String): Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaZQuery('SELECT COUNT(*) AS "QUANT" FROM SKY_CADSGR WHERE SGR_CODSGR = :CODSGR',Self);
  qryGen.ParamByName('CODSGR').AsString := strSGrupo;
  qryGen.Open;
  Result := qryGen.FieldByName('QUANT').AsInteger > 0;
  FreeAndNil(qryGen);
end;

function TfrmCadSkyNovasFormulas.fVerificaMontadora(
  strCodMon: String): Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaZQuery('SELECT COUNT(*) AS "QUANT" FROM SKY_CADMON WHERE MON_CODMON = :CODMON',Self);
  qryGen.ParamByName('CODMON').AsString := strCodMon;
  qryGen.Open;
  Result := qryGen.FieldByName('QUANT').AsInteger > 0;
  FreeAndNil(qryGen);
end;

procedure TfrmCadSkyNovasFormulas.pCdsBeforePost(DataSet: TDataSet);
begin
  If (Not DataSet.FieldByName('NFM_QTDB').IsNull) And (DataSet.FieldByName('NFM_QTDB').AsFloat <= 0) Then
  Begin
    fMensagem('', 'A Quantidade deve ser maior que zero!', ['OK']);
    DataSet.Cancel;
  End;
end;

initialization
  RegisterClass(TfrmCadSkyNovasFormulas);
finalization
  UnRegisterClass(TfrmCadSkyNovasFormulas);

end.

