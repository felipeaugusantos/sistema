unit untCadAdiAjusteApu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, untPaiCad, Vcl.ComCtrls, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, Data.DB, QColorLabel, EditFocus, Uni, StrUtils, UniClientDataSet,
  DBLookupComboBoxFocus;

type
  TfrmCadAdiAjusteApu = class(TfrmPaiCad)
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
    dblIndOri: TDBLookupComboBoxFocus;
    dtsIndOri: TDataSource;
    dbeComple: TDBEditFocus;
    Label4: TLabel;
    Label6: TLabel;
    dbeNumDAE: TDBEditFocus;
    Label7: TLabel;
    dbeNumPAV: TDBEditFocus;
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
    cdsIndOri : TUniClientDataSet;
    procedure pCriaIndOri();
    procedure pPopulaIndOri();
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  end;

Var
  frmCadAdiAjusteApu : TfrmCadAdiAjusteApu;

implementation

{$R *.dfm}

uses untTypesSistema, untFuncoesSimples, untConsultas, untFuncoesConsulta;

{ TfrmCadAdiAjusteApu }

procedure TfrmCadAdiAjusteApu.btnAlterarClick(Sender: TObject);
begin
  inherited;
  If blnAlterou Then
  Begin
    dblIndOri.Enabled := True;
  End;
end;

procedure TfrmCadAdiAjusteApu.btnCancelaClick(Sender: TObject);
begin
  inherited;
  dblIndOri.Enabled := False;
  edtNomEmp.Text := fRetNomeEmpresaSelec(dbeCodEmp.Text);
end;

procedure TfrmCadAdiAjusteApu.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadAdiAjusteApu.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  edtNomEmp.Text := fRetNomeEmpresaSelec(dbeCodEmp.Text);
end;

procedure TfrmCadAdiAjusteApu.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[untCadAdiAjusteApu.btnGravarClick]');
    End;
  End;

  If blnGravou Then
  Begin
    fCommit;
    dblIndOri.Enabled := False;
  End
  Else
    fRollBack;
end;

procedure TfrmCadAdiAjusteApu.btnIncluirClick(Sender: TObject);
begin
  inherited;
  dblIndOri.Enabled := True;
  edtNomEmp.Text := '';
end;

procedure TfrmCadAdiAjusteApu.btnPesquisaClick(Sender: TObject);
var
  arrAjuste : TConsultasArray;
  chrKey : Char;
begin
  chrKey := '/';
  If fPesqAdiAjusteApu(Self, qryTabela, chrKey, arrAjuste) Then
    pSetFocus(btnAlterar);

  edtNomEmp.Text := fRetNomeEmpresaSelec(dbeCodEmp.Text);
end;

procedure TfrmCadAdiAjusteApu.dbeCodEmpExit(Sender: TObject);
var
  arrEmpresa: TConsultasArray;
begin
  pEdtCodSelectExit(dbeCodEmp, edtNomEmp, arrEmpresa, Nil, fRetNomeEmpresaSelec, 'da Empresa');
end;

procedure TfrmCadAdiAjusteApu.dbeCodEmpKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmCadAdiAjusteApu.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(btnIncluir);
end;

procedure TfrmCadAdiAjusteApu.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela       := 'ADIAJU';
  strNomeCampo        := 'AUTOINCREM';
  qryTabela           := fCriaQuery(Self);
  dtsTabela.DataSet   := qryTabela;

  SetLength(arrCamposChave, 4);
  arrCamposChave[0] := dbeCodEmp;
  arrCamposChave[1] := dbeMesAno;
  arrCamposChave[2] := dbeNumDAE;
  arrCamposChave[3] := dbeNumPAV;

  pCriaIndOri();
  pPopulaIndOri();

  dtsIndOri.DataSet := cdsIndOri;
end;

procedure TfrmCadAdiAjusteApu.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(cdsIndOri);
end;

procedure TfrmCadAdiAjusteApu.FormShow(Sender: TObject);
begin
  inherited;
  dblIndOri.Enabled := False;
end;

function TfrmCadAdiAjusteApu.fValidaCampos(Sender: TWinControl;
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
    Else If (Sender = dblIndOri) Then
    Begin
      If fEmptyStr(dblIndOri.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O Indicador da Origem do Processo deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadAdiAjusteApu.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('AJU_CODEMP');
  stlCampos.Add('AJU_MESANO');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('AJU_CODEMP');
  stlCamInd.Add('AJU_MESANO');

  stlDesInd.Add('Empresa');
  stlDesInd.Add('Mês/Ano');
end;

procedure TfrmCadAdiAjusteApu.pCriaIndOri();
begin
  cdsIndOri := TUniClientDataSet.Create(Self);

  With cdsIndOri.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CODTIP';
    DataType := ftString;
    Size     := 1;
  End;

  With cdsIndOri.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'DESTIP';
    DataType := ftString;
    Size     := 50;
  End;

  cdsIndOri.CreateDataSet;
  cdsIndOri.IndexFieldNames := 'CODTIP';
  cdsIndOri.LogChanges := False;
end;

procedure TfrmCadAdiAjusteApu.pPopulaIndOri();

  procedure pInsert(strCodTip, strDesTip: String);
  begin
    cdsIndOri.Insert;
    cdsIndOri.FieldByName('CODTIP').AsString := strCodTip;
    cdsIndOri.FieldByName('DESTIP').AsString := strDesTip;
    cdsIndOri.Post;
  end;

begin
  pInsert('0', '0 - SEFAZ');
  pInsert('1', '1 - JUSTIÇA FEDERAL');
  pInsert('2', '2 - JUSTIÇA ESTADUAL');
  pInsert('9', '9 - OUTROS');
end;

end.
