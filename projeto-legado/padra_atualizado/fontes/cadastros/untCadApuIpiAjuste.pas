unit untCadApuIpiAjuste;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, untPaiCad, Vcl.ComCtrls, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, Data.DB, QColorLabel, EditFocus, Uni, StrUtils, UniClientDataSet,
  DBLookupComboBoxFocus;

type
  TfrmCadApuIpiAjuste = class(TfrmPaiCad)
    Label2: TLabel;
    dbeDesAju: TDBEditFocus;
    dtsTabela: TDataSource;
    pnlGeral: TPanel;
    dbeCodEmp: TDBEditFocus;
    edtNomEmp: TEditFocus;
    Label3: TLabel;
    Label5: TLabel;
    dbeMesAno: TDBEditFocus;
    Label1: TLabel;
    dbeIndAju: TDBLookupComboBoxFocus;
    dbeCodAju: TDBLookupComboBoxFocus;
    dbeIndDoc: TDBLookupComboBoxFocus;
    dtsIndAju: TDataSource;
    dtsCodAju: TDataSource;
    dtsIndDoc: TDataSource;
    dbeNumDoc: TDBEditFocus;
    Label4: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label7: TLabel;
    dbeValAju: TDBEditFocus;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodEmpExit(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    cdsIndAju: TUniClientDataSet;
    cdsCodAju: TUniClientDataSet;
    cdsIndDoc: TUniClientDataSet;
    procedure pCriaIndAju();
    procedure pPopulaIndAju();
    procedure pCriaCodAju();
    procedure pPopulaCodAju();
    procedure pCriaIndDoc();
    procedure pPopulaIndDoc();
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  end;

Var
  frmCadApuIpiAjuste : TfrmCadApuIpiAjuste;

implementation

{$R *.dfm}

uses untTypesSistema, untFuncoesSimples, untConsultas, untFuncoesConsulta;

{ TfrmCadApuIpiAjuste }

procedure TfrmCadApuIpiAjuste.btnAlterarClick(Sender: TObject);
begin
  inherited;
  If blnAlterou Then
  Begin
    dbeIndAju.Enabled := True;
    dbeCodAju.Enabled := True;
    dbeIndDoc.Enabled := True;
  End;
end;

procedure TfrmCadApuIpiAjuste.btnCancelaClick(Sender: TObject);
begin
  inherited;
  dbeIndAju.Enabled := False;
  dbeCodAju.Enabled := False;
  dbeIndDoc.Enabled := False;
  edtNomEmp.Text := fRetNomeEmpresaSelec(dbeCodEmp.Text);
end;

procedure TfrmCadApuIpiAjuste.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadApuIpiAjuste.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  edtNomEmp.Text := fRetNomeEmpresaSelec(dbeCodEmp.Text);
end;

procedure TfrmCadApuIpiAjuste.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadApuIpiAjuste.btnGravarClick]');
    End;
  End;

  If blnGravou Then
  Begin
    fCommit;
    dbeIndAju.Enabled := False;
    dbeCodAju.Enabled := False;
    dbeIndDoc.Enabled := False;
  End
  Else
    fRollBack;
end;

procedure TfrmCadApuIpiAjuste.btnIncluirClick(Sender: TObject);
begin
  inherited;
  dbeIndAju.Enabled := True;
  dbeCodAju.Enabled := True;
  dbeIndDoc.Enabled := True;
  edtNomEmp.Text := '';
end;

procedure TfrmCadApuIpiAjuste.btnPesquisaClick(Sender: TObject);
var
  arrAjuste : TConsultasArray;
  chrKey : Char;
begin
  chrKey := '/';
  If fPesqApuIpiAjuste(Self, qryTabela, chrKey, arrAjuste) Then
    pSetFocus(btnAlterar);

  edtNomEmp.Text := fRetNomeEmpresaSelec(dbeCodEmp.Text);
end;

procedure TfrmCadApuIpiAjuste.dbeCodEmpExit(Sender: TObject);
var
  arrEmpresa: TConsultasArray;
begin
  pEdtCodSelectExit(dbeCodEmp, edtNomEmp, arrEmpresa, Nil, fRetNomeEmpresaSelec, 'da Empresa');
end;

procedure TfrmCadApuIpiAjuste.dbeCodEmpKeyPress(Sender: TObject; var Key: Char);
var
  arrEmpresa: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqEmpresa(conEmpSimples, Self, dbeCodEmp, edtNomEmp, Nil, Key, arrEmpresa) Then
    Begin
      If fValidaCampos(dbeCodEmp, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCadApuIpiAjuste.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(btnIncluir);
end;

procedure TfrmCadApuIpiAjuste.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela       := 'APUIPI';
  strNomeCampo        := 'AUTOINCREM';
  qryTabela           := fCriaQuery(Self);
  dtsTabela.DataSet   := qryTabela;

  //SetLength(arrCamposChave, 2);
  //arrCamposChave[0] := dbeCodEmp;
  //arrCamposChave[1] := dbeMesAno;

  pCriaIndAju();
  pPopulaIndAju();

  pCriaCodAju();
  pPopulaCodAju();

  pCriaIndDoc();
  pPopulaIndDoc();

  dtsIndAju.DataSet := cdsIndAju;
  dtsCodAju.DataSet := cdsCodAju;
  dtsIndDoc.DataSet := cdsIndDoc;
end;

procedure TfrmCadApuIpiAjuste.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(cdsIndAju);
  FreeAndNil(cdsCodAju);
  FreeAndNil(cdsIndDoc);
end;

procedure TfrmCadApuIpiAjuste.FormShow(Sender: TObject);
begin
  inherited;
  dbeIndAju.Enabled := False;
  dbeCodAju.Enabled := False;
  dbeIndDoc.Enabled := False;
end;

function TfrmCadApuIpiAjuste.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender,blnBuscaPorChave)) Then
  Begin
    If (Sender = dbeCodEmp) Then
    Begin
      If fEmptyStr(dbeCodEmp.Text) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'O Código da Empresa deve ser preenchido!', ['&Ok']);
      End
      Else
      Begin
        edtNomEmp.Text := fRetNomeEmpresaSelec(dbeCodEmp.Text);
      End;
    End
    Else If (Sender = dbeMesAno) Then
    Begin
      If fEmptyStr(dbeMesAno.Text) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'Mês/Ano deve ser preenchido!', ['&Ok']);
      End
      Else
      Begin
        Try
          StrToDate('01/' + LeftStr(dbeMesAno.Text, 2) + '/' + RightStr(dbeMesAno.Text, 4));
        Except
          Result := False;
          fMensagem('ATENÇÃO!', 'Mês/Ano inválido! Formato correto: MMAAAA.', ['&Ok']);
        End;
      End;
    End
    Else If (Sender = dbeIndAju) Then
    Begin
      If fEmptyStr(dbeIndAju.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O Indicador do Tipo de Ajuste deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = dbeCodAju) Then
    Begin
      If fEmptyStr(dbeCodAju.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O Código do Ajuste da Apuração deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = dbeValAju) Then
    Begin
      If fEmptyStr(dbeValAju.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O Valor do Ajuste deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = dbeIndDoc) Then
    Begin
      If fEmptyStr(dbeIndDoc.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O Indicador de Origem do Documento deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadApuIpiAjuste.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('IPI_CODEMP');
  stlCampos.Add('IPI_MESANO');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('IPI_CODEMP');
  stlCamInd.Add('IPI_MESANO');

  stlDesInd.Add('Empresa');
  stlDesInd.Add('Mês/Ano');
end;

procedure TfrmCadApuIpiAjuste.pCriaIndAju();
begin
  cdsIndAju := TUniClientDataSet.Create(Self);

  With cdsIndAju.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CODTIP';
    DataType := ftString;
    Size     := 1;
  End;

  With cdsIndAju.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'DESTIP';
    DataType := ftString;
    Size     := 50;
  End;

  cdsIndAju.CreateDataSet;
  cdsIndAju.IndexFieldNames := 'CODTIP';
  cdsIndAju.LogChanges := False;
end;

procedure TfrmCadApuIpiAjuste.pPopulaIndAju();

  procedure pInsert(strCodTip, strDesTip: String);
  begin
    cdsIndAju.Insert;
    cdsIndAju.FieldByName('CODTIP').AsString := strCodTip;
    cdsIndAju.FieldByName('DESTIP').AsString := strDesTip;
    cdsIndAju.Post;
  end;

begin
  pInsert('0', '0 - AJUSTE DE DÉBITO');
  pInsert('1', '1 - AJUSTE DE CRÉDITO');
end;

procedure TfrmCadApuIpiAjuste.pCriaCodAju();
begin
  cdsCodAju := TUniClientDataSet.Create(Self);

  With cdsCodAju.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CODTIP';
    DataType := ftString;
    Size     := 3;
  End;

  With cdsCodAju.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'DESTIP';
    DataType := ftString;
    Size     := 250;
  End;

  cdsCodAju.CreateDataSet;
  cdsCodAju.IndexFieldNames := 'CODTIP';
  cdsCodAju.LogChanges := False;
end;

procedure TfrmCadApuIpiAjuste.pPopulaCodAju();

  procedure pInsert(strCodTip, strDesTip: String);
  begin
    cdsCodAju.Insert;
    cdsCodAju.FieldByName('CODTIP').AsString := strCodTip;
    cdsCodAju.FieldByName('DESTIP').AsString := strDesTip;
    cdsCodAju.Post;
  end;

begin
  pInsert('001', '001 - ESTORNO DE DÉBITO');
  pInsert('002', '002 - CRÉDITO RECEBIDO POR TRANSFERÊNCIA');
  pInsert('010', '010 - CRÉDITO PRESUMIDO DE IPI - RESSARCIMENTO DO PIS/PASEP E DA COFINS - LEI Nº 9.363/1996');
  pInsert('011', '011 - CRÉDITO PRESUMIDO DE IPI - RESSARCIMENTO DO PIS/PASEP E DA COFINS - LEI Nº 10.276/2001');
  pInsert('012', '012 - CRÉDITO PRESUMIDO DE IPI - REGIÕES INCENTIVADAS - LEI Nº 9.826/1999');
  pInsert('013', '013 - CRÉDITO PRESUMIDO DE IPI-FRETE-MP2.158/2001');
  pInsert('019', '019 - CRÉDITO PRESUMIDO DE IPI - OUTROS');
  pInsert('098', '098 - CRÉDITOS DECORRENTES DE MEDIDA JUDICIAL');
  pInsert('099', '099 - OUTROS CRÉDITOS');
  pInsert('101', '101 - ESTORNO DE CRÉDITO');
  pInsert('102', '102 - TRANSFERÊNCIA DE CRÉDITO');
  pInsert('103', '103 - RESSARCIMENTO / COMPENSAÇÃO DE CRÉDITOS DE IPI');
  pInsert('199', '199 - OUTROS DÉBITOS');
end;

procedure TfrmCadApuIpiAjuste.pCriaIndDoc();
begin
  cdsIndDoc := TUniClientDataSet.Create(Self);

  With cdsIndDoc.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CODTIP';
    DataType := ftString;
    Size     := 1;
  End;

  With cdsIndDoc.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'DESTIP';
    DataType := ftString;
    Size     := 50;
  End;

  cdsIndDoc.CreateDataSet;
  cdsIndDoc.IndexFieldNames := 'CODTIP';
  cdsIndDoc.LogChanges := False;
end;

procedure TfrmCadApuIpiAjuste.pPopulaIndDoc();

  procedure pInsert(strCodTip, strDesTip: String);
  begin
    cdsIndDoc.Insert;
    cdsIndDoc.FieldByName('CODTIP').AsString := strCodTip;
    cdsIndDoc.FieldByName('DESTIP').AsString := strDesTip;
    cdsIndDoc.Post;
  end;

begin
  pInsert('0', '0 - PROCESSO JUDICIAL');
  pInsert('1', '1 - PROCESSO ADMINISTRATIVO');
  pInsert('2', '2 - PER/DCOMP');
  pInsert('3', '3 - DOCUMENTO FISCAL');
  pInsert('9', '9 - OUTROS');
end;

end.
